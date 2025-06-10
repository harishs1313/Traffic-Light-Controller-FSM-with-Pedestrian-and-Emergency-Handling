# 🚦 Traffic Light Controller (FSM-based) – Verilog Project

A finite state machine (FSM)-based Traffic Light Controller designed using Verilog HDL. This enhanced design includes pedestrian crossing functionality and an emergency override, making it suitable for real-world traffic management simulations.

## 🧠 Features

- **FSM-based design** with 6 well-defined states.
- **Supports Pedestrian Requests**: Activates pedestrian green lights.
- **Emergency Vehicle Override**: Prioritizes traffic flow for emergencies.
- **Timer-based Transitions**: Realistic signal timing using countdown logic.
- **Simulation-ready**: Includes a testbench and GTKWave-compatible VCD output.
- **Modular Verilog Code**: Easy to expand and modify.

---

## 📂 File Structure

```bash
TrafficLightController/
├── TrafficLightController.v       # Main FSM-based traffic controller
├── TrafficLightController_tb.v    # Testbench for simulation
├── TrafficLightController.vcd     # VCD output for GTKWave
├── README.md                      # This README file
````

---

## 🔧 How It Works

### 🔁 FSM States

* `RED`: Vehicles stop.
* `RED_YELLOW`: Transition prep.
* `GREEN`: Vehicles go.
* `YELLOW`: Warning before stopping.
* `PED_GREEN`: Pedestrian crossing.
* `EMERGENCY_GREEN`: Emergency override.

### 🕒 Timing

Each state has a timer (`timer` register) that counts down before transitioning. Values are reset per state.

### 🎯 Inputs & Outputs

| Signal           | Type   | Description                      |
| ---------------- | ------ | -------------------------------- |
| `clk`            | Input  | System clock                     |
| `reset`          | Input  | Resets FSM to RED state          |
| `pedestrian_req` | Input  | Request to cross for pedestrians |
| `emergency`      | Input  | Emergency signal override        |
| `red`            | Output | Red light for vehicles           |
| `yellow`         | Output | Yellow light for vehicles        |
| `green`          | Output | Green light for vehicles         |
| `ped_red`        | Output | Red light for pedestrians        |
| `ped_green`      | Output | Green light for pedestrians      |

---

## 📐 Simulation Instructions

### 1. Install Required Tools

Ensure you have the following:

* **Icarus Verilog** for compilation
* **GTKWave** for waveform viewing

### 2. Compile and Simulate

```bash
iverilog -o TrafficLightController_sim TrafficLightController.v TrafficLightController_tb.v
vvp TrafficLightController_sim
```

### 3. View Waveform

```bash
gtkwave TrafficLightController.vcd
```

---

## 🧪 Sample Testbench Flow

```verilog
reset = 1; #10;
reset = 0;
pedestrian_req = 1; #100;
pedestrian_req = 0;
emergency = 1; #30;
emergency = 0;
```

---

## 📸 Waveform Output Example

You should see changes in:

* Light signals (red, yellow, green)
* Pedestrian indicators (ped\_red, ped\_green)
* FSM transitions triggered by requests and emergencies

---

## 🛠️ Project Goals

* Learn FSM design using Verilog.
* Apply real-world signal handling logic.
* Simulate and debug using testbenches and waveform viewers.

---

## ✅ Status

✔️ Project Completed
🔄 Ready for enhancements like countdown display, blinking signals, etc.

---

## 🧑‍💻 Author

Harish
*Final-year Engineering Student | Embedded Systems & VLSI Enthusiast*

---

## 📜 License

MIT License – feel free to reuse, modify, and enhance.

```

