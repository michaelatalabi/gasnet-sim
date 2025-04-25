#!/usr/bin/env python3
import zmq, airsim, time, json
ctx = zmq.Context()
sock = ctx.socket(zmq.PUB)
sock.bind("tcp://*:5556")
client = airsim.MultirotorClient()
client.confirmConnection()
while True:
    state = client.getMultirotorState()
    pos = state.kinematics_estimated.position
    msg = {'ts': state.timestamp, 'x': pos.x_val, 'y': pos.y_val, 'z': pos.z_val}
    sock.send_string(json.dumps(msg))
    time.sleep(0.1)
