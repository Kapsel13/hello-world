import React from 'react';

function CalendarComponent(props) {
    return(
        <div className="calendar-content">
            <div className="top-grid">
               <button onClick={props.goPast}>&lt;</button>
               <div className="title-item">{props.month} {props.year}</div>
               <button onClick={props.goForward}>&gt;</button>
            </div>
            <div className="middle-grid">
             <div className="day-of-week">Monday</div>
             <div className="day-of-week">Tuesday</div>
             <div className="day-of-week">Wednesday</div>
             <div className="day-of-week">Thursday</div>
             <div className="day-of-week">Friday</div>
             <div className="day-of-week">Saturday</div>
             <div className="day-of-week">Sunday</div>
            </div>
            <div className="bottom-grid">
             {props.CallendarCard}
            </div>
        </div>
    )
}
export default CalendarComponent;