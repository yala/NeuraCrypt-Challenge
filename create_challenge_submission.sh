cd NeuraCrypt
## Creating demo submission
python scripts/create_submission.py --batch_size 256 --gpus 1  --encoded_data_dir /Mounts/rbg-storage1/users/adamyala/neuracrypt_embeddings/neuracrypt-7 --load_data_from_encoded_dir --submission_dir /Mounts/rbg-storage1/users/adamyala/neuracrypt_challenge/sample_submission

## Creating submission for MMD Attack on linear model
python scripts/create_submission.py --batch_size 256 --gpus 1  --encoded_data_dir /Mounts/rbg-storage1/users/adamyala/neuracrypt_embeddings/neuracrypt-7 --load_data_from_encoded_dir --submission_dir /Mounts/rbg-storage1/users/adamyala/neuracrypt_submissions/neuracrypt_7_MMD/ --snapshot logs/neuracrypt_7_mmd_attack.results
