import os
import json
import argparse
import torch
import importlib

import numpy as np

from sklearn.model_selection import StratifiedKFold
from torch_geometric.loader import DataLoader
from torch_geometric.datasets import TUDataset


def reset_weights(m):
    '''Resets the weights during each fold to avoid weight leakage'''
    for layer in m.children():
        if hasattr(layer, 'reset_parameters'):
            layer.reset_parameters()


def train(train_loader, device, optimizer, model, criterion):
    '''Trains the model on train set'''
    model.train()
    for data in train_loader:
        data = data.to(device)
        optimizer.zero_grad()
        _, z = model(data.x, data.edge_index, data.batch)
        loss = criterion(z, data.y)
        loss.backward()
        optimizer.step()


@torch.no_grad()
def test(test_loader, device, model, criterion, loader_size):
    '''Evaluates the model and returns the accuracy and loss'''
    model.eval()
    acc = 0
    loss = 0
    for data in test_loader:
        data = data.to(device)
        _, z = model(data.x, data.edge_index, data.batch)
        acc += int((z.argmax(dim=1) == data.y).sum()) / loader_size
        loss += criterion(z, data.y) / loader_size
    return acc, loss


def perform_kfold_cv(dataset, train_dataset, train_labels, device, args):
    '''Performs k-fold cross validation'''

    # Initialize the model
    model_module = importlib.import_module(f'gnn_ged.models.{args.arch}')
    model = model_module.Model(
            input_dim=dataset.num_features,
            hidden_dim=args.hidden_dim,
            n_classes=dataset.num_classes,
            n_layers=args.n_layers,
    ).to(device)

    # Define the optimier and criterion
    optimizer = torch.optim.Adam(model.parameters(), lr=args.lr, weight_decay=0.0001)
    criterion = torch.nn.CrossEntropyLoss()

    # Perform K-fold cross validation
    k_fold = 10
    kf = StratifiedKFold(n_splits=k_fold, shuffle=True, random_state=None)

    # Perform k-fold cross validation to get an estimate of the model's accuracy
    val_accuracies = []
    val_losses = []

    for fold, (train_idx, val_idx) in enumerate(kf.split(train_dataset, train_labels)):
        print(f'--------\nFold {fold + 1}\n--------')

        # Define the data loaders for the current fold
        train_loader = DataLoader(
            dataset=train_dataset,
            batch_size=args.batch_size,
            sampler=torch.utils.data.SubsetRandomSampler(train_idx),
        )
        
        val_loader = DataLoader(
            dataset=train_dataset,
            batch_size=args.batch_size,
            sampler=torch.utils.data.SubsetRandomSampler(val_idx),
        )

        # Reset the weights
        model.apply(reset_weights)

        # Train the model on the train set
        for epoch in range(args.epochs):
            train(train_loader, device, optimizer, model, criterion)

        # Evaluate the model on the test set
        val_accuracy, val_loss = test(val_loader, device, model, criterion, len(val_idx))
        val_accuracies.append(val_accuracy)
        val_losses.append(val_loss)

        # Write logs
        log_stats = {'Fold': fold+1, 'Validation accuracy': val_accuracy}
        with open(os.path.join(args.output_dir, 'log_cv.txt'), 'a') as f:
           f.write(json.dumps(log_stats) + '\n')

        print(f'Val Loss: {val_loss:.4f} | Val Accuracy: {val_accuracy*100:.2f}%\n')
    
    print(f'Average val Accuracy: {np.mean(val_accuracies)*100:.2f}%\n')

    with open(os.path.join(args.output_dir, 'log_cv.txt'), 'a') as f:
        f.write(json.dumps({'Validation accuracies': val_accuracies}) + '\n')
        f.write(json.dumps({'Average accuracy': np.mean(val_accuracies)}) + '\n')


def get_args_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument('--dataset_dir', type=str, help='Path to dataset directory')
    parser.add_argument('--dataset_name', type=str, help='Dataset name')
    parser.add_argument('--arch', type=str, choices=['gin', 'gat', 'gcn', 'gsage'], help='GNN architecture')
    parser.add_argument('--batch_size', type=int, default=64, help='Training batch size')
    parser.add_argument('--hidden_dim', type=int, default=64, help='Hidden channel dimension')
    parser.add_argument('--n_layers', type=int, default=3, help='Number of convolution layers')
    parser.add_argument('--epochs', type=int, default=201, help='Number of epochs')
    parser.add_argument('--lr', type=float, default=1e-4, help='Learning rate')
    parser.add_argument('--indices_dir', type=str, help='Path to indices')
    parser.add_argument('--output_dir', type=str, help='Path to output directory')
    return parser


def main(args):

    log_args = {k:str(v) for (k,v) in sorted(dict(vars(args)).items())}
    with open(os.path.join(args.output_dir, 'log_cv.txt'), 'a') as f:
        f.write(json.dumps(log_args) + '\n')

    # Set device to CUDA
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')

    # Load the dataset from TUDataset
    dataset = TUDataset(root=args.dataset_dir, name=args.dataset_name)
    
    dataset_idx = np.arange(0, len(dataset))
    np.random.shuffle(dataset_idx)

    train_idx = np.load(os.path.join(args.indices_dir, 'train_indices.npy'))

    train_labels = [dataset[i].y.item() for i in train_idx]

    # Perform k-fold cross-testidation
    train_dataset = dataset[train_idx]
    perform_kfold_cv(dataset, train_dataset, train_labels, device, args)


if __name__ == '__main__':
    parser = get_args_parser()
    args = parser.parse_args()
    main(args)