import React from 'react';
function TrafficLightsComponent(props){
    return (
     <div>
        <h2>Traffic Lights Simulator</h2>
        <div className="main-container">
          <div className="lights-container">
            <div className="driver-lights-container">
                {props.driverLightsContent}
            </div>
            <div className="pedestrian-lights-container">
                {props.pedestrianLightsContent}
            </div>
           </div>
           <form>
                <input 
                    name="timeOfShining"
                    value={props.time}
                    placeholder="Enter Changing Lights Time in sec"
                    maxLength="2"
                    onChange={props.setTime}
                />
            </form>
            <button onClick={props.runSimulator}>Run Traffic Lights Simulator</button>
        </div>
      </div>
    )
}
export default TrafficLightsComponent;