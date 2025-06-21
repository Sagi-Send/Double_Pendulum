# Double-Pendulum (MATLAB)

A MATLAB script that

1. solves the nonlinear double-pendulum equations with `ode45`,
2. shows a live animation, and
3. saves that animation to **`double_pendulum.gif`**.

> No extra toolboxes, no helper files – just run **`double_pendulum.m`**.

---

## Requirements
* MATLAB R2018b or newer  
  (older versions work too if you replace the Greek-letter variable names).

---

## How to run

```bash
git clone https://github.com/<your-user>/double-pendulum.git
cd double-pendulum
matlab -batch "run('double_pendulum.m')"   # CLI

---

![Double-pendulum demo](double_pendulum.gif)
