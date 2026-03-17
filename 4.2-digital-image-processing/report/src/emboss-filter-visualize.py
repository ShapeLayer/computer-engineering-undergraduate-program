import matplotlib.pyplot as plt
from matplotlib.ticker import MultipleLocator
import numpy as np

data = np.array([
    # [4, 3, 2],
    # [3, 3, 1],
    # [2, 1, 0],
    

    [0, 1, 2],
    [1, 3, 3],
    [2, 3, 4],
])

nx, ny = data.shape
nz = np.max(data)

voxels = np.zeros((nx, ny, nz), dtype=bool)
for i in range(nx):
    for j in range(ny):
        height = data[i, j]
        if height > 0:
            voxels[i, j, :height] = True

x, y, z = np.indices((nx + 1, ny + 1, nz + 1))
z_shifted = z - 2

fig = plt.figure(figsize=(10, 8))
ax = fig.add_subplot(111, projection='3d')

colors = plt.cm.inferno(np.linspace(0.2, 1, nz))
voxel_colors = np.zeros(voxels.shape + (4,))
for k in range(nz):
    voxel_colors[:, :, k] = colors[k]

ax.voxels(x, y, z_shifted, voxels, facecolors=voxel_colors, edgecolor='k', linewidth=0.3)

floor_x, floor_y = np.meshgrid(np.arange(nx + 1), np.arange(ny + 1))
floor_z = np.full_like(floor_x, -2)
ax.plot_surface(floor_x, floor_y, floor_z, color='lightgray', alpha=1.0, zorder=0)

ax.xaxis.set_major_locator(MultipleLocator(1))
ax.yaxis.set_major_locator(MultipleLocator(1))
ax.zaxis.set_major_locator(MultipleLocator(1))

ax.set_xlim(0, nx)
ax.set_ylim(0, ny)
ax.set_zlim(-2, nz - 2)

ax.set_box_aspect([1, 1, 1])
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')
ax.view_init(elev=25, azim=45)

plt.tight_layout()
plt.show()
