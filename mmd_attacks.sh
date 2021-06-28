cd NeuraCrypt
## Run MMD Attack on Linear encoding
python scripts/main.py --batch_size 32 --dataset stanford_cxr_edema  --gpus 1 --private --use_adv  --use_mmd_adv  --encoded_data_dir /Mounts/rbg-storage1/users/adamyala/neuracrypt_embeddings/linear  --private_depth -1 --load_data_from_encoded_dir  --remove_pixel_shuffle --test_on_encoded_dir --train --test --weight_decay 0.001 --init_lr 1e-04 --max_epochs 25 --results_path logs/linear_mmd_attack.results


## Run MMD Attack on NeuraCrypt 7 encoding
python scripts/main.py --batch_size 32 --dataset stanford_cxr_edema  --gpus 1 --private --use_adv  --use_mmd_adv  --encoded_data_dir /Mounts/rbg-storage1/users/adamyala/neuracrypt_embeddings/neuracrypt-7  --private_depth 4 --load_data_from_encoded_dir --test_on_encoded_dir --train --weight_decay 0.001 --init_lr 1e-04 --max_epochs 25 --results_path logs/neuracrypt_7_mmd_attack.results
