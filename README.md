# Double-Pendulum Simulation (MATLAB)

<p align="center">
  <img src="figs/double_pendulum.gif" width="360" alt="Animated double-pendulum trajectory">
</p>

A compact MATLAB project that **numerically solves** the nonlinear double-pendulum equations, **animates** the motion in real time, and **exports** the animation to an animated GIF.

---

## 📖 Theory
The double-pendulum is a classic example of a chaotic Hamiltonian system.
The system of coupled, second-order ODEs is derived via Lagrange’s equations for two point masses connected by massless rods.

---

## 🗂️ Repository layout

| File / folder | Purpose |
|--------------|---------|
| `Init.m` | Define physical parameters and initial conditions. |
| `Solver.m` | Integrates the equations of motion via `ode45`. |
| `Plotter.m` | Handles live animation, trajectory trace, and GIF export. |
| `main.m` | Orchestrates the entire simulation (calls *Init*, *Solver*, *Plotter*). |
| `figs/` | Output directory automatically created for exported GIFs. |
| `README.md` | You are here. |

---

## 🚀 Quick-start

```bash
# clone the repository
git clone https://github.com/<your-user>/double-pendulum.git
cd double-pendulum

# run from the MATLAB GUI
% in MATLAB command window
>> main    % press Run