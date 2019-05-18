import React from 'react'
import CalculatorComponent from './CalculatorComponent'

class CalculatorContainer extends React.Component {
    state = {
        calcExpression : "",
        calcOperand: "",
        calcResult: "",
        calcOperator: "",
        calcLastClicked: ""
    }
    
    handleClick = (event) =>{
        let prevCalcResult = this.state.calcResult;
        let prevCalcOperand = this.state.calcOperand;
        let prevCalcExpression = this.state.calcExpression;
        const {innerHTML} = event.target;
        switch(true){
            case innerHTML === "CE" :
            {
                this.setState({
                    calcExpression: "",
                    calcResult: "",
                    calcOperator: "",
                    calcOperand: ""
                });
            }
            break;
            case innerHTML === "." :
            {
                if(this.state.calcResult !== ""){
                    if(this.state.calcOperator !== ""){
                         if(!this.state.calcOperand.includes(".")){
                            this.setState({
                                calcOperand: prevCalcOperand + innerHTML,
                                calcExpression: prevCalcExpression + innerHTML
                             })
                            }
                    }
                    else{
                        if(!this.state.calcResult.includes(".")){
                            this.setState({
                                calcResult: prevCalcResult + innerHTML,
                                calcExpression: prevCalcExpression + innerHTML
                            })
                        }
                    }

                }
            }
            break;
            case (innerHTML >= 0 && innerHTML <10):
            {
                if(this.state.calcResult === ""){
                     this.setState({
                         calcExpression: innerHTML,
                         calcResult: innerHTML
                     })
                }
                else {
                    if((this.state.calcLastClicked >= 0 && this.state.calcLastClicked < 10) ||(this.state.calcLastClicked === ".")){
                        this.state.calcOperator !== "" ?
                         this.setState({
                              calcOperand: prevCalcOperand + innerHTML,
                              calcExpression: prevCalcExpression + innerHTML
                         })
                         :
                         this.setState({
                             calcResult: prevCalcResult + innerHTML,
                             calcExpression: prevCalcExpression + innerHTML
                         })
                    }
                    else{
                        this.setState({
                            calcExpression: innerHTML,
                            calcOperand: innerHTML
                        })
                    }
                }
            }
            break;
            default: 
            {
                if(this.state.calcOperand === ""){
                        this.setState({
                            calcOperator: innerHTML
                        })
                }
                else {
                    switch(this.state.calcOperator){
                        case "+" : {
                            prevCalcResult = parseFloat(prevCalcResult) + parseFloat(prevCalcOperand);
                        }
                        break;
                        case "-" : {
                            prevCalcResult = parseFloat(prevCalcResult) - parseFloat(prevCalcOperand);
                        }
                        break;
                        case "x" : {
                            prevCalcResult = parseFloat(prevCalcResult) * parseFloat(prevCalcOperand);
                        }
                        break;
                        case "/" : {
                            prevCalcOperand != 0 ? 
                                prevCalcResult = parseFloat(prevCalcResult) / parseFloat(prevCalcOperand)
                            :
                                prevCalcResult = "ERROR"
                        }
                        break;
                        case "%" : {
                            prevCalcOperand != 0 ? 
                                prevCalcResult = parseFloat(prevCalcResult) % parseFloat(prevCalcOperand)
                            :
                            prevCalcResult = "ERROR"
                        }
                        break;
                        case "x^n" : {
                            prevCalcResult = Math.pow(prevCalcResult,prevCalcOperand);
                        }
                    }
                    if(prevCalcResult === "ERROR"){
                        this.setState({
                            calcExpression: prevCalcResult,
                            calcResult: "",
                            calcOperator: "",
                            calcOperand: ""
                        });
                    }
                    else{
                        this.setState({
                            calcResult: prevCalcResult,
                            calcExpression: prevCalcResult,
                            calcOperator: innerHTML
                        })
                    }
                }
            }
        }
        this.setState({
            calcLastClicked: innerHTML
        })
    }
    render(){
        return(
            <CalculatorComponent inputText={this.state.calcExpression} handleClick={this.handleClick} />
        )
    }
}
export default  CalculatorContainer