import React, {Component} from 'react';
import CalendarComponent from './CalendarComponent';

class CalendarContainer extends Component {
    constructor(){
        super();
        this.state = {
            month: "",
            year: "",
            day: "",
            todayDay: "",
            todayMonth: "",
            todayYear: "",  
            daysOfCurrentCalendarCard: []
        }
        this.MONTHS = ["January","February","March","April","May","June","July","August","September","October","November","December"];
    }
    //function creating callendar card and return it as array
    createCallendarCard = (actualDayOfMonth,actualDayOfWeek,numberOfMonth,actualYear) => {
        let first  = actualDayOfMonth - (parseInt(actualDayOfWeek,10)-1); 
        while(first>0){                  // first actualDayOfWeek in Month
            first -= 7;
        }
        let CurrentCallendarCard = [];
        let firstDayinActualCalendarCard = 0; 
        switch(true){
            case numberOfMonth === 0 ||  numberOfMonth === 7 : {   
                firstDayinActualCalendarCard = parseInt(first,10) + 31;        //January and August case
                for(let i = firstDayinActualCalendarCard; i<=31; i++){
                    CurrentCallendarCard.push(i);
                }
                for(let i=1;i<=31;i++){
                    CurrentCallendarCard.push(i);
                }
            }
            break;
            case numberOfMonth === 1 : {
                firstDayinActualCalendarCard = parseInt(first,10) + 31;
                for(let i = firstDayinActualCalendarCard; i<=31; i++){
                    CurrentCallendarCard.push(i);                               //February case
                }
                for(let i=1;i<=28;i++){
                    CurrentCallendarCard.push(i);
                }
                if(actualYear % 4 === 0){
                    CurrentCallendarCard.push(29);
                }
            }
            break;
            case (numberOfMonth === 2) : {
                if(actualYear % 4 === 0){
                 firstDayinActualCalendarCard = parseInt(first,10) + 29;
                 for(let i = firstDayinActualCalendarCard; i<=29; i++){
                    CurrentCallendarCard.push(i);
                 }
                }    
                else{
                    firstDayinActualCalendarCard = parseInt(first,10) + 28;       //March case
                    for(let i = firstDayinActualCalendarCard; i<=28; i++){
                        CurrentCallendarCard.push(i);
                     }
                }
                for(let i=1;i<=31;i++){
                    CurrentCallendarCard.push(i);
                }                                                                          
            }
            break;
            case (numberOfMonth<=6 && numberOfMonth % 2 === 0) || (numberOfMonth>7 && numberOfMonth % 2 === 1) : {
                firstDayinActualCalendarCard = parseInt(first,10) + 30;         // May,July,October,December
                for(let i = firstDayinActualCalendarCard; i<=30; i++){
                    CurrentCallendarCard.push(i);
                }
                for(let i=1;i<=31;i++){
                    CurrentCallendarCard.push(i);
                }
            }
            break;
            case (numberOfMonth<=6 && numberOfMonth % 2 === 1) || (numberOfMonth>7 && numberOfMonth % 2 === 0) : {
                firstDayinActualCalendarCard = parseInt(first,10) + 31;        // April,June,September,November
                for(let i = firstDayinActualCalendarCard; i<=31; i++){
                    CurrentCallendarCard.push(i);
                }
                for(let i=1;i<=30;i++){
                    CurrentCallendarCard.push(i);
                }
            }
        }
        let nextMonthItems = 1;
        for(let i=CurrentCallendarCard.length;i<42;i++){
            CurrentCallendarCard.push(nextMonthItems);                         //completing calendar card with next month days
            nextMonthItems++;
        }
        return CurrentCallendarCard;
    }
    //before rendering function set calendar card as actual month
    componentDidMount(){
        const actualDate = new Date();    
        const actualDayOfMonth = actualDate.getDate(); 
        let actualDayOfWeek = actualDate.getDay();
        if(actualDayOfWeek === 0){
            actualDayOfWeek  = 7;
        }
        let actualMonth = "";
        const numberOfMonth = actualDate.getMonth();
        actualMonth = this.MONTHS[numberOfMonth];
        const actualYear = actualDate.getFullYear();

        this.setState({
            month: actualMonth,
            year: actualYear,
            day: actualDayOfMonth,
            todayDay: actualDayOfMonth,
            todayMonth: actualMonth,
            todayYear: actualYear, 
            daysOfCurrentCalendarCard: this.createCallendarCard(actualDayOfMonth,actualDayOfWeek,numberOfMonth,actualYear)
        });
    }
    //changing calendar card to the past
    goToPreviousMonth = () => {
        let actualYear = this.state.year;
        let actualMonth=this.state.month;
        const actualDay = this.state.day;
        let indexOfActualMonth = "";
         //updating month and year if nessasary
        if(actualMonth === "January"){
            actualMonth = "December";
            indexOfActualMonth = this.MONTHS.lastIndexOf(actualMonth);
            actualYear -= 1;
           }
           else{
               indexOfActualMonth = this.MONTHS.lastIndexOf(actualMonth)-1;
               actualMonth = this.MONTHS[indexOfActualMonth];
           }
          //updating the calendar card
         const date = new Date(actualYear,indexOfActualMonth,actualDay);
         const numberOfMonth = date.getMonth();
         let dayOfWeek = date.getDay();
         if(dayOfWeek === 0){
            dayOfWeek  = 7;
         }
         this.setState({
            month: actualMonth,
            year: actualYear,
            daysOfCurrentCalendarCard: this.createCallendarCard(actualDay,dayOfWeek,numberOfMonth,actualYear)
        })
    }
    //changing calendar card to the future
    goToNextMonth = () => {
        let actualYear = this.state.year;
        let actualMonth=this.state.month;
        const actualDay = this.state.day;
        let indexOfActualMonth = "";
        //updating month and year if nessasary
        if(actualMonth === "December"){
            actualMonth = "January";
            actualYear += 1;
            indexOfActualMonth = this.MONTHS.lastIndexOf(actualMonth);
           }
           else{
                indexOfActualMonth = this.MONTHS.lastIndexOf(actualMonth) + 1;
               actualMonth = this.MONTHS[indexOfActualMonth];
           }
            //updating the calendar card
           const date = new Date(actualYear,indexOfActualMonth,actualDay);
           const numberOfMonth = date.getMonth();
           let dayOfWeek = date.getDay();
           if(dayOfWeek === 0){
              dayOfWeek  = 7;
           }
           this.setState({
               month: actualMonth,
               year: actualYear,
               daysOfCurrentCalendarCard: this.createCallendarCard(actualDay,dayOfWeek,numberOfMonth,actualYear)
           })
    }
    render(){
        let CallendarCardInColor = [];
        let indexOfTodayDay = 0;
        let i = 0;
        while(i<20){
            if((this.state.daysOfCurrentCalendarCard[i] >= 1)&&(this.state.daysOfCurrentCalendarCard[i]<=20)){
                if(this.state.daysOfCurrentCalendarCard[i] === this.state.todayDay){
                    indexOfTodayDay = i;
                }
                CallendarCardInColor.push(<div className="day-of-month">{this.state.daysOfCurrentCalendarCard[i]}</div>);
            }
            else{
                CallendarCardInColor.push(<div className="day-of-previous-month">{this.state.daysOfCurrentCalendarCard[i]}</div>);
            }
            i++;
        }
        while(i<42){
            if((this.state.daysOfCurrentCalendarCard[i] >= 15)&&(this.state.daysOfCurrentCalendarCard[i]<=31)){
                if(this.state.daysOfCurrentCalendarCard[i] === this.state.todayDay){
                    indexOfTodayDay = i;
                }
                CallendarCardInColor.push(<div className="day-of-month">{this.state.daysOfCurrentCalendarCard[i]}</div>);
            }
            else{
                CallendarCardInColor.push(<div className="day-of-previous-month">{this.state.daysOfCurrentCalendarCard[i]}</div>);
            }
            i++;
        }
        if((this.state.month === this.state.todayMonth)&&(this.state.year === this.state.todayYear)){
            CallendarCardInColor[indexOfTodayDay] = <div className="today">{this.state.daysOfCurrentCalendarCard[indexOfTodayDay]}</div>;
        }
        return (
            <CalendarComponent 
                month={this.state.month}
                year={this.state.year}
                daysOfCurrentMonth={this.state.daysOfCurrentCalendarCard}
                goPast={this.goToPreviousMonth} 
                goForward={this.goToNextMonth}
                CallendarCard={CallendarCardInColor}
            />
        )
    }
}
export default CalendarContainer;