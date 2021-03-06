# NeuraCrypt Challenge

Challenge dataset for [NeuraCrypt](https://arxiv.org/abs/2106.02484), a private encoding scheme based on random deep neural networks. 
NeuraCrypt encodes raw patient data using a randomly constructed neural network known only to the data-owner, and publishes both the encoded data and associated labels publicly. In our paper, we demonstrate the existence of an optimal family of encoding functions that achieves perfect privacy against even a computationally unbounded adversary. However, it is infeasible to leverage this optimal family of encoding functions directly, so we instead approximate it with deep neural networks. We note the proofs in our paper do not extend to our neural network implementation and so we release this challenge to characterize the privacy of our proposed NeuraCrypt architectures. 

Given a NeuraCrypt coded dataset, the challenge is to reidentify the original data or recover the private NeuraCrypt encoder `T`. We note that these notions are interchangeable, as with `T`, an attacker could recover the images with a plaintext attack and vice-versa. We explore the security of NeuraCrypt encodings in two settings, a simplified setting where the attacker has access to the plaintext version of encoded data and a harder real-world setting where the attacker only has access to distributionally matched plaintext data.

All challenges are done using subsets of the [CheXPert dataset](https://stanfordmlgroup.github.io/competitions/chexpert/). For each challenge, we release several versions of encodings to explore how the security of NeuraCrypt varies by architecture.

We release encodings for:
- Linear Encoder (Easy to break)
- NeuraCrypt depth 3 - No Shuffle
- NeuraCrypt depth 3  
- NeuraCrypt depth 7 (As used in the paper)
- NeuraCrypt depth 47

We evaluate the security of an encoding via reidentification (reid) accuracy, which is analogous to an effective `k-anonymity`. For our intended clinical use cases, we consider a reid accuracy of <5% (i.e k > 20 for k-anonymity) to provide "good" privacy, an accuracy 5-20% (i.e k in 5-20) to provide "moderate" privacy, an accuracy of >20%  (i.e k < 5) to provide "bad" privacy. An attacker "wins" a challenge if they can show NeuraCrypt-7 or NeuraCrypt-47 obtains "bad" privacy.

The challenges can be downloaded from Amazon S3 at `s3://neuracrypt-challenge`. The raw CheXpert dataset can be obtained [here](https://stanfordmlgroup.github.io/competitions/chexpert/). We used the small pre-compressed version of the dataset. 

### Challenge 1: Reidentifying patients from matching datasets 

In this challenge, the attacker has access to an encoded subset of the CheXpert dataset, the set of image paths (i.e image IDs) that the encoded data come from, as well as the entire raw (i.e plaintext) CheXpert dataset. The attacker may also leverage any external resources, such as the MIMIC-CXR dataset, in their attack. The task is to predict which encoded image comes from which source image path.  We compute the accuracy of the matching between the true and predicted image IDs.

While in real world scenarios, an attacker would not have access to matching raw images, this simplified setting offers an informative benchmark in understanding the privacy offered by NeuraCrypt architectures. 

### Baselines
The MMD attack presented in the [paper](https://arxiv.org/abs/2106.02484) can obtain a >99% accuracy on the linear encodings in this challenge. However, it does not obtain an accuracy >5% on NeuraCrypt-7.

The MMD attack was run using `mmd_attacks.sh`.


### Challenge 2: Identifying T from distributionally matched datasets (Harder but real-world)

In this challenge, the attacker has access to an encoded subset of the CheXpert dataset, but does not have access to the plaintext version of those images for any part of the attack. However, the attacker may use any other subsets of the CheXpert dataset, which are distributionally similar, and any other public X-ray dataset such as MIMIC-CXR. The task is to predict the image-encodings for a target subset of the CheXpert dataset and thus prove that the attacker recovered `T`.  We note that the target subset and released encoded dataset do not overlap and using the plaintext version of the encoded data in any way is not allowed for this challenge.

We evaluate the attacker's candidate `T'` on the target set of images `A` by whether `T???(x)` has `T(x)` as it???s nearest neighbor (via MSE) among `{T(x???), x??? in A}`. Since patches may be shuffled, we evaluate the distance between two `z` as the MSE between their average patches which ignores the patch ordering. We compute the accuracy of this matching.

### Baselines
The MMD attack presented in the [paper](https://arxiv.org/abs/2106.02484) can obtain a >99% accuracy on the linear encodings in this challenge. However, it does not obtain an accuracy >5% on NeuraCrypt-7. 

The MMD attack was run using `mmd_attacks.sh`.

## Implementation Details

All source code used for NeuraCrypt and the NeuraCrypt challenge are available [here](github.com/yala/NeuraCrypt). The datasets were generated for each setting using `generate_datasets.sh`. For each encoding, there is a `private_encoded_dataset` directory, `private_encoded_dataset_path_list.json` and `challenge_2_target_dataset_path_list.json`. The `private_encoded_dataset` directory contains numpy files for each encoded image, `private_encoded_dataset_path_list.json` identifies which paths (i.e image IDs) from the CheXpert dataset are in `private_encoded_dataset`, and `challenge_2_target_dataset_path_list.json`identifies the image paths (i.e subset of CheXpert) for which to submit encodings for Challenge 2. We note that the two json lists are unordered and do not release the solution.

A sample submission is shown in the `sample_submission` directory on S3. This was created using `create_challenge_submission.sh`. This contains `parallel_data_predictions.json`, `out_of_domain_npy_path_to_orig_path_dict.json`, and the `challenge_2_target_dataset` directory. `parallel_data_predictions.json` contains the submission for Challenge 1, and predicts a numpy file (e.g `8262.npy`) for each source CheXpert image path.  `challenge_2_target_dataset` contains numpy files for the target images in Challenge 2 and  `out_of_domain_npy_path_to_orig_path_dict.json` contains the mapping from CheXpert image paths to encoded image paths (`challenge_2_target_dataset`).

Please follow our submission format and email your submission to adamyala@mit.edu when you are ready. 

Submissions are evaluated using `scripts/evaluate_submission.py` in the [NeuraCrypt codebase](https://github.com/yala/NeuraCrypt). 
Please email adamyala@mit.edu or post an issue if you have any questions. 

## Leaderboards
## Challenge 1: Reidentifying patients from matching datasets 
| Encoding | Attack Author | ReID Acc | 
| ----: | :----: | :----: |
| **Depth 7** | **Nicholas Carlini** | **100%**|
| Depth 3, no shuffle | Nicholas Carlini | 100% |

**Nicholas Carlini has solved Challenge 1. We link his attack writeup when it is available online.**

## Challenge 2: Identifying T from distributionally matched datasets (Harder but real-world)

No submissions recieved yet.
Note, this challenge is won when an attack obtains > 20% accuracy on Depth-7 or Depth-47.


## Citing the NeuraCrypt Challenge
```
@misc{yala2021neuracrypt,
      title={NeuraCrypt: Hiding Private Health Data via Random Neural Networks for Public Training}, 
      author={Adam Yala and Homa Esfahanizadeh and Rafael G. L. D' Oliveira and Ken R. Duffy and Manya Ghobadi and Tommi S. Jaakkola and Vinod Vaikuntanathan and Regina Barzilay and Muriel Medard},
      year={2021},
      eprint={2106.02484},
      archivePrefix={arXiv},
      primaryClass={cs.CR}
}
```

## Acknowledgements
We would like to thank Nicholas Carlini for helpful feedback in designing the challenge. 

## Sponsors
We are lucky to be supported by: [JClinic](https://www.jclinic.mit.edu/) and [Wellcome Trust](https://wellcome.org/)







