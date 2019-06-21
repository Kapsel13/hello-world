import React from 'react';
import movieNames from "./moviesnames";
function MovieComponent(props) {
    const selectContent = movieNames.map((item)=><option value={item.title}>{item.title}</option>);
    return(
        <div>
            <h2>Play your favourite movie theme</h2>
            <div className="movie-container">
             {props.movieImg}
            <br />
            <div className="play-theme">
                <select
                    name="movieTitle"
                    value={props.movieTitle}
                    onChange={props.movieChange}
                >
                {selectContent}
                </select>
                <button onClick={props.playTheme}>Play theme</button>
             </div>
            </div>
            <h2>Bellow write your comment about the movie with your nickname without using * char</h2>
            <div className="comment-container">
                <div className="add-comment">
                    <input 
                           name="nickName"
                           value={props.nickName}
                           onChange={props.createComment}
                           placeholder="Enter your nick"
                           maxLength="10"
                    />
                    <textarea
                           name="comment"
                           value={props.comment}
                           onChange={props.createComment}
                           placeholder="Write your comment"
                           maxLength="250"
                    >
                    </textarea>
                    <button onClick={props.addComment}>Add comment</button>
                </div>
                <h2>Comment section</h2>
                {props.commentdata}
            </div>
        </div>
    )
}
export default MovieComponent;