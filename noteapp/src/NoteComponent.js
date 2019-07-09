import React from 'react';
function NoteComponent(props){
    return(
           <div>
            <h1>Note app</h1>
            <hr/>
            <div className="note-app-content">
              {props.noteData}
              {props.buttonData}
            </div>
          </div>
    );
}
export default NoteComponent;