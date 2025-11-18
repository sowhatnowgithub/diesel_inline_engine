# Diesel Injection Line – MATLAB Simulation

This repository contains MATLAB scripts for simulating different parts of a diesel engine fuel-injection system.  
The focus of the latest update is **LinePump.m**, which models the pressure dynamics in the high-pressure pipe between the line pump and injector pump using a simplified physical model with fluid compressibility, plunger kinematics, and flow balance.

---

## 📁 Repository Contents

| File | Description |
|------|-------------|
| **LinePump.m** | Simulates pressure in the fuel line between line pump and injector pump using ODE dynamics. |
| **ParamControl.m** | Contains engine and injector parameter presets. |
| **Plot_for_various_speed.m** | Runs injector model for different RPM values. |
| **Test_your_param_plot.m** | Visualization tool to test camshaft and injector parameters. |
| **afr_air_demand.m** | Air–fuel ratio and air demand calculation script. |
| **plot_for_acceleraiton.m** | Acceleration-based injection/airflow visualization. |

![Screenshot](https://github.com/user-attachments/assets/deb2051b-b572-42c3-8c12-54391ccb8d09)

---

## 🔧 LinePump Model — Overview

The goal of **LinePump.m** is to compute line pressure based on the flow path:

**Line Pump (low-pressure plunger) → High-Pressure Line → Injector Pump (high-pressure plunger)**

### 1. **Plunger Motion**

Plungers follow a smooth half-cosine stroke profile:

**Position:**

$$x(t) = \frac{S}{2}(1 - \cos(\omega t))$$

**Velocity:**

$$v(t) = \frac{S}{2}\omega \sin(\omega t)$$

Where:
- $S$ = stroke length
- $\omega$ = angular velocity (rad/s)
- $t$ = time

This motion profile is used for both:
- Line pump (inflow source)
- Injector pump (outflow destination)

---

## 🔽 Flow Model

### **Inflow from Line Pump**
Flow occurs only when the plunger moves upward:

$$Q_{in}(t) = A_{line} \cdot \max(v_{line}(t), 0)$$

Where:
- $A_{line}$ = cross-sectional area of line pump plunger
- $v_{line}(t)$ = velocity of line pump plunger

### **Outflow to Injector Pump**
Flow occurs only during the injector pump's upward stroke:

$$Q_{out}(t) = A_{inj} \cdot \max(v_{inj}(t), 0)$$

Where:
- $A_{inj}$ = cross-sectional area of injector pump plunger
- $v_{inj}(t)$ = velocity of injector pump plunger

### **Leakage**
Simple linear leakage model to the fuel tank:

$$Q_{leak} = k_{leak}(P - P_{tank})$$

Where:
- $k_{leak}$ = leakage coefficient
- $P$ = line pressure
- $P_{tank}$ = tank pressure (typically atmospheric)

---

## 📘 Pressure Dynamics Formula (Core ODE)

Fuel in the line has finite bulk modulus $\beta$, representing its compressibility.  
Pressure changes based on net volumetric compression according to:

$$\frac{dP}{dt} = \frac{\beta}{V_{line}} \left( Q_{in} - Q_{out} - Q_{leak} \right)$$

Where:
- $\beta$ = bulk modulus of fuel (Pa)
- $V_{line}$ = volume of high-pressure line (m³)
- $Q_{in}$ = inflow from line pump (m³/s)
- $Q_{out}$ = outflow to injector pump (m³/s)
- $Q_{leak}$ = leakage flow (m³/s)

This ordinary differential equation (ODE) captures the essential physics of pressure rise and fall in the fuel line during the injection cycle.

---

## 📊 What the Script Plots

The simulation generates three key visualizations:

1. **Plunger Lifts**  
   Comparison of line pump and injector pump plunger positions over time

2. **Line Pressure**  
   Evolution of high-pressure line pressure throughout the cycle

3. **Flow Rates**  
   - $Q_{in}$: Inflow from line pump  
   - $Q_{out}$: Outflow to injector pump  
   - $Q_{leak}$: Leakage to fuel tank  

These plots provide clear insight into how pressure rises and falls during the plunger cycle and the relationship between plunger motion, flow rates, and pressure dynamics.

---

## 🚀 Getting Started

1. Clone the repository
2. Open MATLAB
3. Run `LinePump.m` to see the basic pressure dynamics simulation
4. Use `ParamControl.m` to adjust engine parameters
5. Explore other scripts for different operating conditions and analyses

---

## 📝 Notes

- The model assumes incompressible flow except for the bulk modulus effect in the line
- Leakage is modeled as a simple linear function; real systems may have more complex leakage characteristics
- The half-cosine plunger motion is a simplified representation; actual cam profiles may differ

---

