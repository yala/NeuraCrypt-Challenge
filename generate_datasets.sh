cd NeuraCrypt

python scripts/export.py --batch_size 256 --dataset stanford_cxr_edema  --gpus 1 --private --private_depth -1 --remove_pixel_shuffle --encoded_data_dir /Mounts/rbg-storage1/users/adamyala/neuracrypt_embeddings/linear

python scripts/export.py --batch_size 256 --dataset stanford_cxr_edema  --gpus 1 --private --private_depth 0 --remove_pixel_shuffle --encoded_data_dir /Mounts/rbg-storage1/users/adamyala/neuracrypt_embeddings/neuracrypt-2-no-shuffle

python scripts/export.py --batch_size 256 --dataset stanford_cxr_edema  --gpus 1 --private --private_depth 0 --encoded_data_dir /Mounts/rbg-storage1/users/adamyala/neuracrypt_embeddings/neuracrypt-2

python scripts/export.py --batch_size 256 --dataset stanford_cxr_edema  --gpus 1 --private --private_depth 4 --encoded_data_dir /Mounts/rbg-storage1/users/adamyala/neuracrypt_embeddings/neuracrypt-7

python scripts/export.py --batch_size 256 --dataset stanford_cxr_edema  --gpus 1 --private --private_depth 44 --encoded_data_dir /Mounts/rbg-storage1/users/adamyala/neuracrypt_embeddings/neuracrypt-47
