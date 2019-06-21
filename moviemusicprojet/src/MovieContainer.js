import React, {Component} from 'react';
import MovieComponent from "./MovieComponent";
import moviePictures from "./moviepictures";
import movieThemes from "./moviethemes";
import movieNames from './moviesnames';
class MovieContainer extends Component {
    constructor(){
        super();
        this.state = {
            movieImgSrc : moviePictures[0],
            movieTitle: movieNames[0].title,
            nickName: "",
            comment: "",
            addedcomment: ""
        };
        this.movieTheme = new Audio(movieThemes[0]);
    }
    movieChange = (event) =>{
        this.movieTheme.pause();
        const {name,value} = event.target;
        const pictureId = movieNames.findIndex((item) => item.title === value);
        const moviePicture = moviePictures[pictureId];
        this.setState({
            [name]: value,
            movieImgSrc: moviePicture
        });
    }
    playTheme = () => {
        const movieSongId = movieNames.findIndex((item) => item.title === this.state.movieTitle);
        const movieSong = movieThemes[movieSongId];
        this.movieTheme.pause();
        this.movieTheme = new Audio(movieSong);
        this.movieTheme.play();
    }
    createComment = (event) => {
        const {name,value} = event.target;
        this.setState({
            [name]: value
        });
    }
    addComment = () => {
        let nick = this.state.nickName;
        let comment= this.state.comment;
        if(localStorage.getItem(String(this.state.movieTitle)+"nick") === null){
            let nickData = "*"+String(nick);
            let commentData = "*"+String(comment);
            localStorage.setItem(String(this.state.movieTitle)+"nick",nickData);
            localStorage.setItem(String(this.state.movieTitle)+"comment",commentData);
        }
        else{
            let nickData = localStorage.getItem(String(this.state.movieTitle)+"nick");
            let commentData = localStorage.getItem(String(this.state.movieTitle)+"comment")
            nickData=nickData+"*"+String(nick);
            commentData=commentData+"*"+String(comment);
            localStorage.setItem(String(this.state.movieTitle)+"nick",nickData);
            localStorage.setItem(String(this.state.movieTitle)+"comment",commentData);

        }
        this.setState({
            addComment: 1
        });
    }
    render(){
        let movieImg=<img src={this.state.movieImgSrc} />;
        let commentdata = [];
        //console.log(this.state.movieTitle);
        if(localStorage.getItem(String(this.state.movieTitle)+"nick") !== null){
            let nickDataItems = localStorage.getItem(String(this.state.movieTitle)+"nick").split("*");
            let commentDataItems = localStorage.getItem(String(this.state.movieTitle)+"comment").split("*");
            for(let i=0;i<nickDataItems.length;i++){
                if(nickDataItems[i]!=""){
                    commentdata.push(<div className="comment-item"><p className="nick">{nickDataItems[i]}</p><p>{commentDataItems[i]}</p></div>);
                }
            }
        }
        return(
            <MovieComponent 
                movieImg={movieImg} 
                movieTitle={this.state.movieTitle} 
                movieChange={this.movieChange} 
                nickName={this.state.nickName} 
                comment={this.state.comment} 
                createComment={this.createComment}
                addComment={this.addComment}
                commentdata={commentdata}
                playTheme={this.playTheme}
            />
        )
    }
}
export default MovieContainer;