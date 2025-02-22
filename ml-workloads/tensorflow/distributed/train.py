# distributed/train.py

import tensorflow as tf
import argparse
import os

# Define command-line arguments
parser = argparse.ArgumentParser(description='Distributed TensorFlow training')
parser.add_argument('--strategy', type=str, default='mirrored',
                    choices=['mirrored', 'multiworker'],
                    help='Distribution strategy to use (mirrored or multiworker)')
parser.add_argument('--epochs', type=int, default=10,
                    help='Number of training epochs')
parser.add_argument('--batch_size', type=int, default=32,
                    help='Batch size for training')
parser.add_argument('--model_dir', type=str, default='./model',
                    help='Directory to save the trained model')
args = parser.parse_args()

# --- Data Loading ---
def create_dataset():
    # Create a dummy dataset for demonstration purposes.
    # Replace this with your actual data loading logic.
    num_samples = 1000
    num_features = 10
    (x_train, y_train), _ = tf.keras.datasets.mnist.load_data()
    x_train = x_train.reshape(-1, 784).astype('float32') / 255.0
    y_train = y_train.astype('int64')

    # Create a tf.data.Dataset from the numpy arrays
    dataset = tf.data.Dataset.from_tensor_slices((x_train, y_train))
    dataset = dataset.repeat().shuffle(num_samples).batch(args.batch_size)
    return dataset

# --- Model Definition ---
def create_model():
    # Define a simple Keras model.
    # Replace this with your actual model architecture.
    model = tf.keras.models.Sequential([
        tf.keras.layers.Dense(512, activation='relu', input_shape=(784,)),
        tf.keras.layers.Dropout(0.2),
        tf.keras.layers.Dense(10, activation='softmax')
    ])
    return model

# --- Training Loop ---
def train(strategy):
    # Create the dataset
    dataset = create_dataset()

    # Create the model within the strategy's scope
    with strategy.scope():
        model = create_model()
        optimizer = tf.keras.optimizers.Adam()
        loss_fn = tf.keras.losses.SparseCategoricalCrossentropy(from_logits=False)  # Corrected line

        model.compile(optimizer=optimizer,
                      loss=loss_fn,
                      metrics=['accuracy'])
    # Save the model
    checkpoint_dir = os.path.join(args.model_dir, 'checkpoints')
    checkpoint_callback = tf.keras.callbacks.ModelCheckpoint(
        filepath=os.path.join(checkpoint_dir, 'checkpoint_{epoch}'),
        save_weights_only=True,
        save_freq='epoch'
    )
    # Train the model
    model.fit(dataset,
              epochs=args.epochs,
              steps_per_epoch=100,  # Adjust based on your dataset size and batch size
              callbacks=[checkpoint_callback]) # add model checkpoint callback
    return model

# --- Main ---
if __name__ == '__main__':
    # Initialize distribution strategy based on the command-line argument
    if args.strategy == 'mirrored':
        strategy = tf.distribute.MirroredStrategy()
    elif args.strategy == 'multiworker':
        strategy = tf.distribute.MultiWorkerMirroredStrategy()
    else:
        raise ValueError("Invalid strategy. Choose 'mirrored' or 'multiworker'.")

    print(f"Using distribution strategy: {strategy}")

    # Train the model
    trained_model = train(strategy)

    # Save the trained model
    model_save_path = os.path.join(args.model_dir, 'final_model')
    trained_model.save(model_save_path)  # Save the entire model
    print(f"Model saved to: {model_save_path}")