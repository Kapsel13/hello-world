import React from 'react'

function CalculatorComponent(props){
    return(
        <div className="calculator-content">
            <h2>Calculator</h2>
            <form>
                <input
                    type="text"
                    name="calcExpression"
                    value={props.inputText}
                    readOnly
                />
            </form>
            <hr />
            <div className="grid-container">
                <button className="red-item" onClick={props.handleClick}>CE</button>
                <button className="gray-item" onClick={props.handleClick}>x^n</button>
                <button className="gray-item" onClick={props.handleClick}>%</button>
                <button className="gray-item" onClick={props.handleClick}>/</button>
                <button className="gray-item" onClick={props.handleClick}>7</button>
                <button className="gray-item" onClick={props.handleClick}>8</button>
                <button className="gray-item" onClick={props.handleClick}>9</button>
                <button className="gray-item" onClick={props.handleClick}>x</button>
                <button className="gray-item" onClick={props.handleClick}>4</button>
                <button className="gray-item" onClick={props.handleClick}>5</button>
                <button className="gray-item" onClick={props.handleClick}>6</button>
                <button className="gray-item" onClick={props.handleClick}>-</button>
                <button className="gray-item" onClick={props.handleClick}>1</button>
                <button className="gray-item" onClick={props.handleClick}>2</button>
                <button className="gray-item" onClick={props.handleClick}>3</button>
                <button className="plus-item" onClick={props.handleClick}>+</button>
                <button className="gray-item" onClick={props.handleClick}>0</button>
                <button className="gray-item" onClick={props.handleClick}>.</button>
                <button className="gray-item" onClick={props.handleClick}>=</button>
            </div>
        </div>
    )
}
export default CalculatorComponent