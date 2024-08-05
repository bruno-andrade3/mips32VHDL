import os
import subprocess
import sys

def run_command(command):
    """Run a shell command and check for errors."""
    print(f"Running command: {command}")
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"Error: {result.stderr}")
        return False
    print(result.stdout)
    return True

def process_file(vhdl_file, vcd_dir):
    """Process a single VHDL file."""
    tb_base_name = os.path.splitext(os.path.basename(vhdl_file))[0]
    tb_full_name = f"tb_{tb_base_name}.vhd"
    tb_full_path = os.path.join(os.getcwd(), tb_full_name)

    if not os.path.isfile(tb_full_path):
        print(f"Warning: Testbench file '{tb_full_name}' not found. Skipping simulation for '{vhdl_file}'.")
        return

    # Analyze the VHDL file and testbench file
    if not run_command(f"ghdl -a --std=08 \"{os.path.join(os.getcwd(), vhdl_file)}\""):
        return
    if not run_command(f"ghdl -a --std=08 \"{tb_full_path}\""):
        return

    # Find the entity name in the testbench file
    tb_name = None
    with open(tb_full_path, 'r') as file:
        for line in file:
            if line.strip().startswith('entity'):
                parts = line.split()
                if len(parts) > 1:
                    tb_name = parts[1].split('(')[0]
                    break

    if tb_name is None:
        print(f"Error: Unable to find entity name in testbench file: {tb_full_path}")
        return

    # Elaborate the testbench
    if not run_command(f"ghdl -e --std=08 {tb_name}"):
        return

    # Run the simulation and generate VCD file
    vcd_file = os.path.join(vcd_dir, f"{tb_name}.vcd")
    if not run_command(f"ghdl -r --std=08 {tb_name} --vcd=\"{vcd_file}\""):
        return

    print(f"Simulation completed for '{vhdl_file}'. VCD file is located in '{vcd_file}'")

def main():
    dir_path = os.getcwd()

    vcd_dir = os.path.join(dir_path, 'vcd_files')
    if not os.path.exists(vcd_dir):
        os.makedirs(vcd_dir)

    # Process all VHDL files in the directory
    print("Processing VHDL files...")
    for file in os.listdir(dir_path):
        if file.endswith(".vhd") and not file.startswith("tb_"):
            process_file(file, vcd_dir)

if __name__ == "__main__":
    main()