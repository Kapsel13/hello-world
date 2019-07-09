import React, { Component } from 'react';
import NoteComponent from "./NoteComponent";
class NoteContainer extends Component {
    constructor(){
        super();
        this.state = {
            noteData: "",
            buttonData: "",
            newNoteText: "",
            editNoteText: "",
            previousNoteText: ""
        }
    }
    addNote = () => {
        let noteText = <textarea name="newNoteText" onChange={this.editNote} placeholder="Write your note..."></textarea>;
        let buttonDataContent = <button className="add-button" onClick={this.saveNewNote}>Save note</button>
        this.setState({
            noteData: noteText,
            buttonData: buttonDataContent
        })
    }
    editNote = (event) =>{
        const {name,value} = event.target;
        this.setState({
            [name]: value
        });
    }
    displayNotes = () =>{
        let numberOfNotes = localStorage.getItem("notenumber");
        let noteData = [];
        for(let i=1;i<=numberOfNotes;i++){
            let noteDataContent = localStorage.getItem("note"+String(i));
            if(noteDataContent!=""){
                noteData.push(<div className="note"><p onClick={this.editNoteContent}>{noteDataContent}</p></div>);
                noteData.push(<hr/>);
            }
        }
        let buttonDataContent = <button className="add-button" onClick={this.addNote}>Add note</button>;
        this.setState({
            noteData: noteData,
            buttonData: buttonDataContent
        });
    }
    deleteNote = () =>{
        let numberOfNotes = localStorage.getItem("notenumber");
        for(let i=1;i<=numberOfNotes;i++){
            if(localStorage.getItem("note"+String(i))==this.state.previousNoteText){
                localStorage.removeItem("note"+String(i));
            }
        }
        this.displayNotes();
    }
    editNoteContent = (event) =>{
        let noteText = <textarea name="editNoteText" onChange={this.editNote}>{event.target.innerText}</textarea>;
        let buttonDataContent = <div><button className="delete-button" onClick={this.deleteNote}>Delete note</button><button className="save-button" onClick={this.saveEditNote}>Save note</button></div>;
        this.setState({
            noteData: noteText,
            buttonData: buttonDataContent,
            previousNoteText: event.target.innerText
        });
    }
    saveNewNote = () =>{
        if(localStorage.getItem("note1")===null){
            let data = this.state.newNoteText;
            localStorage.setItem("note1",data);
            localStorage.setItem("notenumber",1);
        }
        else{
            let data = localStorage.getItem("notenumber");
            data++;
            localStorage.setItem("note"+String(data),this.state.newNoteText);
            localStorage.setItem("notenumber",data);
        }
        this.displayNotes();
    }
    saveEditNote = () =>{
        let numberOfNotes = localStorage.getItem("notenumber");
        for(let i=1;i<=numberOfNotes;i++){
            if(localStorage.getItem("note"+String(i))==this.state.previousNoteText){
                localStorage.setItem("note"+String(i),this.state.editNoteText);
            }
        }
        this.displayNotes();
    }
    componentDidMount(){
        let noteDataContent = "";
        let buttonDataContent = "";
        if(localStorage.getItem("note1")===null){
            noteDataContent = <h2>Sorry you have not any notes yet ...</h2>;
            buttonDataContent = <button className="add-button" onClick={this.addNote}>Add note</button>
            this.setState({
                noteData: noteDataContent,
                buttonData: buttonDataContent
            });
        }
        else{
            this.displayNotes();
        }
    }
    render(){
        return <NoteComponent noteData={this.state.noteData} buttonData={this.state.buttonData}/>;
    }
}
export default NoteContainer;