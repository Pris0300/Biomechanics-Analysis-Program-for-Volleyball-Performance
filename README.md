# Biomechanics-Analysis-Program-for-Volleyball-Performance

This repository contains MATLAB scripts for analyzing joint angles during a jump-based motion capture experiment. Each script processes movement data to extract angles related to:

- **Flexion-Extension**
- **Abduction-Adduction**
- **Rotation**

## 👥 Team Project

This program was developed as part of a group collaboration. I contributed to:
- Designing and implementing the knee angle analysis algorithm
- Preprocessing movement data
- Visualizing joint angle trends across different movements

## 🧪 Tools & Technologies

- MATLAB
- Signal processing techniques
- Biomechanical modeling principles
- Vicon motion capture system for 3D kinematic data acquisition

## 📁 Files Included

- `flexion_extension.m`: Script to run flexion-extension analysis
- `abduction_adduction.m`: Script to run abduction-adduction analysis
- `rotation.m`: Script to run rotation analysis
- `data/`: Sample data files
- `README.md`: Documentation

## 📊 Dataset

All scripts use motion capture data stored in `Data.xlsx`. The dataset contains the 3D coordinates of markers placed on a participant's:

- Left leg and left thigh
- Right leg and right thigh

Each participant performed a jump, and the data is segmented into different sheets (e.g., `A00819216_PD`, `A00819216_MD`, etc.) corresponding to different body parts and sides.

## ▶️ Scripts Overview

Each script calculates angular movement based on vector projections of marker data. Plots show:

- Angular displacement over time (for left and right legs)
- Vertical displacement (height) as a reference for jump cycles

### 1. `flexion_extension.m`
Analyzes sagittal plane motion using `Z`-axis and `Y`-axis projections.

### 2. `abduction_adduction.m`
Analyzes frontal plane motion using `Z` and `X`-axis projections.

### 3. `rotation.m`
Analyzes transverse plane motion using `X` and `Y`-axis projections.

## 📌 Notes

- Scripts use symbolic math for readability but could be optimized for performance.
- You may need to adjust file paths depending on your working directory.
- Tested in MATLAB R2023a.

## 📷 Example Output
- **Flexion-Extension**
  ![image](https://github.com/user-attachments/assets/06e16e59-bc3e-4c34-b19c-f1dbd7bd40a1)
- **Abduction-Adduction**
  ![image](https://github.com/user-attachments/assets/0f4811bd-049f-40b2-9ec9-431e53976705)
- **Rotation**
  ![image](https://github.com/user-attachments/assets/fdf8842f-55dc-49e9-b457-0a5c4bb2715b)

## IMPORTANT
*Due to the collaborative nature of this project, only code and components I directly worked on are included.*

---

