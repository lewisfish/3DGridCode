import matplotlib.pyplot as plt
import numpy as np

fig, ax = plt.subplots()

# read in data
file = "data/jmean/fluence.dat"
data = np.fromfile(file, dtype=np.float64, sep="")
# set the number of voxels here, e.g (nxg, nyg, nzg)
voxels = (201, 201, 201)
data = data.reshape(voxels, order="F")

# plot a slice though middle of fluence grid
ax.imshow(data[:, :, 100])
plt.show()
