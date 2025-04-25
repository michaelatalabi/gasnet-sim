#!/usr/bin/env python3
"""Parameter-sweep driver for GASNet simulation."""
import subprocess, itertools, argparse, pathlib, shutil

PARAM_GRID = {
    "rainRate": [0, 25],
    "attack": ["none", "udp_flood"],
}

def run(cfg, tag):
    cmd = [
        "docker", "compose", "run", "--rm", "sim",
        "opp_run", "-n", "/inet/src:/Simu5G/src:/workspace/configs",
        "-l", "/inet/src/libINET.so", "configs/omnetpp.ini",
        "-c", "General",
        f'*.radioMedium.rainRate={cfg["rainRate"]}'
    ]
    subprocess.run(cmd, check=True)
    out_dir = pathlib.Path("output") / tag
    out_dir.mkdir(parents=True, exist_ok=True)
    for pcap in pathlib.Path("output").glob("*.pcap"):
        shutil.move(str(pcap), out_dir / pcap.name)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--quick_demo", action="store_true")
    args = parser.parse_args()
    if args.quick_demo:
        run({"rainRate": 25, "attack": "none"}, "demo")
    else:
        for rain, attack in itertools.product(*PARAM_GRID.values()):
            cfg = {"rainRate": rain, "attack": attack}
            tag = f"rain{rain}_{attack}"
            run(cfg, tag)
