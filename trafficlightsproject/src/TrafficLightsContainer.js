import React, { Component } from 'react';
import TrafficLightsComponent from './TrafficLightsComponent'
import Alarm from './Alarm.mp3'
import Tornado from './Tornado.mp3'

class TrafficLightsContainer extends Component {
    constructor(){
        super();
        this.audio = new Audio(Alarm);
        this.state = {
            timeOfShining : "",
            driverLights : [],
            intervalId: ""
        };
    }
    setTime = (event) => {
        const {name,value} = event.target;
        this.setState({
            [name]: value
        })
    }
    changeDriversLights = () =>{
        let shiningLight = "";
        let i=0;
        while(this.state.driverLights[i] === "black"){
            i++;
        }
        shiningLight = this.state.driverLights[i];
        switch(shiningLight){
            case "red" :{
                this.setState({
                    driverLights: ["black","black","green"]
                });
                this.audio.pause();
                this.audio = new Audio(Tornado);           //when red light for pedestrians starts shining, tornado alarm starts playing
                this.audio.play();
            }
            break;
            case "green" :{
                this.setState({
                    driverLights: ["black","yellow","black"]
                });
            }
            break;
            case "yellow" :{
                this.setState({
                    driverLights: ["red","black","black"]
                });
                this.audio.pause();
                this.audio = new Audio(Alarm);            //When green light for pedestrians starts shining ,beeping alarm starts playing
                this.audio.play();
            }
            break;
        }
    }
    runSimulator = () =>{
        const time = this.state.timeOfShining*1000;
        if(this.state.intervalId!==""){
            clearInterval(this.state.intervalId);
        }
        this.setState({
            intervalId:  setInterval(this.changeDriversLights,time)
        });
    }
    componentDidMount(){
        this.setState({
            driverLights: ["red","black","black"]                //only red light shines on the beginnig
        });
    }
    render(){
        let driverLightsContent = [];
        let pedestrianLightsContent = [];
        for(let i=0;i<3;i++){
            let lightColor = this.state.driverLights[i];
            switch(lightColor){
                case "red":{
                    driverLightsContent.push(<div className="red-light"></div>);
                    pedestrianLightsContent.push(<div className="turn-Off-light"></div>);
                    pedestrianLightsContent.push(<div className="go-light">GO</div>);
                }
                break;
                case "green":{
                    driverLightsContent.push(<div className="green-light"></div>);
                    if(pedestrianLightsContent.length === 0){
                        pedestrianLightsContent.push(<div className="stop-light">STOP</div>);
                        pedestrianLightsContent.push(<div className="turn-Off-light"></div>);
                    }
                }
                break;
                case "yellow":{
                    driverLightsContent.push(<div className="yellow-light"></div>);
                    if(pedestrianLightsContent.length === 0){
                        pedestrianLightsContent.push(<div className="stop-light">STOP</div>);
                        pedestrianLightsContent.push(<div className="turn-Off-light"></div>);
                    }
                }
                break;
                default : {
                    driverLightsContent.push(<div className="black-light"></div>);
                }
            }
        }
        return (
            <TrafficLightsComponent time={this.state.timeOfShining} setTime={this.setTime} runSimulator={this.runSimulator} driverLightsContent={driverLightsContent} pedestrianLightsContent={pedestrianLightsContent} />
        );
    }
}
export default TrafficLightsContainer;