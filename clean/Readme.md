Biometric Vein Recognition
===

Introduction
===
This project explored the identification of individuals using the unique vein patterns in their fingers
The SDUMLA-HMT database was used a source of vein images

The relevant code used for this project is contained in this directory.
Each of the directories has a "demo.m" MATLAB file which can be run as a quick demo of the particular classifier
There are separate directories for each classifier.

Directory structure
===

The exact structure of this directory is as follows

common/					Contains scripts used by a variety of functions. Ensure that this directory is in your MATLAB path when running

experimental_data/		Contains the training database and score matrices which were created when testing. The demoes load data from here to speed up the demonstration (It generally takes about 15 minutes to initially load the database, and then another 15 or so minutes to train each classifier)

mhd_classifier			Contains relevant code for the MHD Classifier. Run "demo.m" for a quick overview. Run "demo_extended" to populate the training database as opposed to reading the database in the "experiemental_data" folder. 

cluster_classifier		Contains releveant code for the Cluster Classifier. Run "demo.m" for a quick overview. It loads the training database from the "experimental_data folder"

local_binary_patterns	The top level directory contains functions used by all three LBP classifers. There are subdirectories for the Canonical LBP, Uniform LBP and Fourier LBP classifiers, each with their own demoes

svm_fusion				Contains code for the SVM fusion classifier. The provided example fuses together the Canonical LBP and MHD classifiers.	


Other notes:
It is advisable to run these scripts from your hard-drive as opposed to off the CD. Some scripts write data to their current directory, which is not possible when running off a read-only CD-ROM. 


Source control
===
This repository can be found on Github: https://github.com/hmph/vein-recognition
The "clean" folder contains this source code
The "experiments" folder contains all the code developed throughout the project. The commits in this directory show the historical development of the project