%{
#define YYSTYPE std::string
#include<stdio.h>
#include<iostream>
#include <vector>
#include <cstdlib>
#include <string>
#include <string.h>
#include <stack>
#include<cstdlib> 
#include <fstream>
#include<map>
#include <ctype.h>
using namespace std;
extern int yylineno;
int yylex(void);
void yyerror(const char*);
int blad=0;
int numorders=0;// ilość rozkazów
int number_of_line=0;//ilość linijek
int asign=0;
int asign_num=0;
int asign_var=0;
int asign_table=0;
long int m_range=0;   //zakres pamięci
long int msize2=0;//msize,msize2 -zmienne potrzebne do pamiętania dodatkowych wartości
long int msize=0;
long int msize3=0;
long int msize4=0;
long int msize5='Z';      //mszie5,msize6,msize7 - dodatkowe miejsca w pamięci służace do zapamiętywania adresów typu a[i],gdzie i ulega zmianie
long int msize6='Z';
long int msize7='Z';
long int msize8='Z';    //dodatkowe miejsce w pamięci służące do przechowywania ilości obrotów pętli for
int condition=0; // flaga warunku
int condition_num=0;
int condition_var=0;
int rd=0;
int wr=0;
int loop=0;  // flaga informująca o tym czy wystąpiła już pętla (potrzebna przy błędzie nie zainicjowanej zmiennej)
int stos_pusty=1;//flaga informująca o tym że wykonywana instrukcja jest instrukcją prostą
int i,j,read,write,index_p,wymiar,index_el,write_only_num,write_num,k,start,asign_num1,asign_num2,index_p2,index_p3,index_temp,adres_el_tab_temp;
int pluss,minuss,timess,divide,modulo,condition_num1,condition_num2,adres_el_tab,adres_el_tab2,adres_el_tab3;
vector<pair<string,long int> > symbols;//tablica symboli(nazwy zmiennych,zakres każdej zmiennej)
vector<string> tables;     //zapamiętujemy nazwy tablic
vector<string> v_bin;  //pomocniczy wektor służący do obliczania wartości liczby w logarytmicznym czasie
vector<pair<string,long int> > pom; //pomocniczy wektor par
stack<int> jumpforward;
stack<int> jumpbackward;
stack<int> idfor;
stack<string> rodzajfor;
vector<pair<int,int> >  jumpforward_ed;
vector<string> kodProgramu;
string zmienna,zmienna2,str,write_arg;
int znal,znal2,idforvalue;
char znak;
int jump='Z';
void liczba_bin(){
		while(k>0){
                	if(k%2==0){
                        	str="SHL";
                                v_bin.push_back(str);
                                k=k/2;
			}
                        else{
                        	str="INC";
                                v_bin.push_back(str);           //funkcja służąca do obliczania wartości liczby w logarytmicznym czasie
                                k=k-1;
		        }
                }
                for(start=v_bin.size()-1;start>=0;start--){
			kodProgramu.push_back(v_bin[start]);
			numorders++;
		}
                v_bin.clear();
}
%}

%token pidentifier num VAR BEGUN 
%token END WRITE READ ASIGN SEMICOLON IF THEN ELSE ENDIF WHILE DO ENDWHILE FOR FROM TO ENDFOR DOWNTO 
%token EQUAL NEQUAL SMALLER GRATTER SMEQUAL GTEQUAL
%token PLUS MINUS TIMES DIVIDE MODULO
%token LSQB RSQB 

%left PLUS MINUS
%left TIMES DIVIDE MODULO
%start program
%%
  program:
  VAR vdeclarations BEGUN commands  END {if(blad==0)
                                       {kodProgramu.push_back("HALT");
					numorders++;
                                        }
                                      };
   
  vdeclarations:
   vdeclarations pidentifier{if(blad==0){
                                if(number_of_line==0)
                                  number_of_line=2;
                                zmienna=$2;
                                i=0;
                                znal=0;
                                while(i<symbols.size()&&(znal==0))
                                {
                                 if(zmienna==symbols[i].first)
                                  {blad=1;
                                   yyerror(("Blad w lini "+to_string(yylineno-1)+": "+"druga deklaracja "+zmienna).c_str());
                                   znal=1;
                                  }
                                  i++;
                                }
				i=0;
				znal=0;
				while((i<zmienna.length())&&(znal==0)){
					znak=zmienna[i];
					if(islower(znak)==0){
						blad=1;
						yyerror(("Blad w lini "+to_string(yylineno-1)+": "+"Nierozpoznany napis: "+zmienna).c_str());
						znal=1;
					}
					i++;
				}
                               if(znal==0)
                                symbols.push_back(make_pair(zmienna,1));                                
                             }
  			     if(number_of_line==2)
				number_of_line++;
			     m_range++;
                           }
   | vdeclarations pidentifier LSQB num RSQB{if(blad==0){
				if(number_of_line==0)
                                   number_of_line=2;
                                zmienna=$2;
                                i=0;
                                znal=0;
                                while(i<symbols.size()&&(znal==0))
                                {
                                 if(zmienna==symbols[i].first)
                                  {blad=1;
                                   yyerror(("Blad w lini "+to_string(yylineno-1)+": "+"druga deklaracja "+zmienna).c_str());
                                   znal=1;
                                  }
                                 i++;
                                }
				i=0;
				znal=0;
				while((i<zmienna.length())&&(znal==0)){
					znak=zmienna[i];
					if(islower(znak)==0){
						blad=1;
						yyerror(("Blad w lini "+to_string(yylineno-1)+": "+"Nierozpoznany napis: "+zmienna).c_str());
						znal=1;
					}
					i++;
				}
                                if(znal==0)
                                 { wymiar=atoi($4.c_str());
                                  symbols.push_back(make_pair(zmienna,wymiar));
				  tables.push_back(zmienna);
                                 }                                   
                             }
			     if(number_of_line==2)
				number_of_line++;
			     m_range=m_range+wymiar;					
                          }
   |;
commands    : commands command
             | command
;
command    : identifier AS expression SEMICOLON{int result_asign=0;
							if(blad==0){
							  if(msize5!='Z')
							  	index_p=msize5;
							  if(msize6!='Z')
							        index_p2=msize6;
							  if(msize7!='Z')
							  	index_p3=msize7;
							  if(!idfor.empty()){
							  	if(index_p==idfor.top()){
									yyerror(("Blad w lini "+to_string(yylineno)+": "+"Modyfikacja zmiennej sterującej pętlą ").c_str());
									blad=1;
								}
							 }
							 //cout<<asign_num<<" "<<asign_table<<" "<<asign_var<<endl;
							if(((asign_num==1)&&(asign_var+asign_table==1))||(asign_num==2)){
								if(asign_num==2){
									if(pluss==1)
										result_asign=asign_num1+asign_num2;
									if(minuss==1){
										result_asign=asign_num1-asign_num2;
	                                                                        if(result_asign<0)
											result_asign=0;
									}
									if(timess==1)
										result_asign=asign_num1*asign_num2;
									if(divide==1){
										if(asign_num2==0)
											result_asign=0;
										else
											result_asign=asign_num1/asign_num2;
									}
									if(modulo==1){
										if(asign_num2==0)
											result_asign=0;
										else
											result_asign=asign_num1%asign_num2;
									}
								}
								else
									result_asign=asign_num1;
								kodProgramu.push_back("ZERO");
								numorders++;
								k=result_asign;
								liczba_bin();
								if(msize5!='Z')
									kodProgramu.push_back("STOREI "+to_string(index_p));
								else
									kodProgramu.push_back("STORE "+to_string(index_p));
								numorders++;
							}
							if((asign_var+asign_table==2)&&(asign_num==0)){  
								if(msize6!='Z')
									kodProgramu.push_back("LOADI "+to_string(index_p2));
								else
									kodProgramu.push_back("LOAD "+to_string(index_p2));
								if(msize5!='Z')
									kodProgramu.push_back("STOREI "+to_string(index_p));
								else
									kodProgramu.push_back("STORE "+to_string(index_p));
								numorders=numorders+2;
							}
							if((asign_var+asign_table+asign_num==3)){
								if(pluss==1){
									if(asign_num==1){
										kodProgramu.push_back("ZERO");
										numorders++;
										if(asign_num1!='Z')
											k=asign_num1;
										else
											k=asign_num2;
										liczba_bin();
										if(msize6!='Z')
											kodProgramu.push_back("ADDI "+to_string(index_p2));
										else
											kodProgramu.push_back("ADD "+to_string(index_p2));
										if(msize5!='Z')
											kodProgramu.push_back("STOREI "+to_string(index_p));
										else
											kodProgramu.push_back("STORE "+to_string(index_p));
										numorders=numorders+2;
									}
									if(asign_num==0){
										if(msize6!='Z')
											kodProgramu.push_back("LOADI "+to_string(index_p2));
										else
											kodProgramu.push_back("LOAD "+to_string(index_p2));
										if(msize7!='Z')
											kodProgramu.push_back("ADDI "+to_string(index_p3));
										else
											kodProgramu.push_back("ADD "+to_string(index_p3));
										if(msize5!='Z')
											kodProgramu.push_back("STOREI "+to_string(index_p));
										else
											kodProgramu.push_back("STORE "+to_string(index_p));
										numorders=numorders+3;
									}
								}
								if(minuss==1){
									if(asign_num==1){
										kodProgramu.push_back("ZERO");
										numorders++;
										msize=m_range;
										if(asign_num1=='Z'){
											k=asign_num2;
											liczba_bin();
											kodProgramu.push_back("STORE "+to_string(msize));
											if(msize6!='Z')
												kodProgramu.push_back("LOADI "+to_string(index_p2));
											else
												kodProgramu.push_back("LOAD "+to_string(index_p2));
											kodProgramu.push_back("SUB "+to_string(msize));
											if(msize5!='Z')
												kodProgramu.push_back("STOREI "+to_string(index_p));
											else
												kodProgramu.push_back("STORE "+to_string(index_p));
											numorders=numorders+4;
										}
										else{
											k=asign_num1;
											liczba_bin();
											if(msize6!='Z')
												kodProgramu.push_back("SUBI "+to_string(index_p2));
											else
												kodProgramu.push_back("SUB "+to_string(index_p2));
											if(msize5!='Z')
												kodProgramu.push_back("STOREI "+to_string(index_p));
											else
												kodProgramu.push_back("STORE "+to_string(index_p));
											numorders=numorders+2;
										}
									}
									if(asign_num==0){
										if(msize6!='Z')
											kodProgramu.push_back("LOADI "+to_string(index_p2));
										else
											kodProgramu.push_back("LOAD "+to_string(index_p2));
										if(msize7!='Z')
											kodProgramu.push_back("SUBI "+to_string(index_p3));
										else
											kodProgramu.push_back("SUB "+to_string(index_p3));
										if(msize5!='Z')
											kodProgramu.push_back("STOREI "+to_string(index_p));
										else
											kodProgramu.push_back("STORE "+to_string(index_p));
										numorders=numorders+3;
									}
								}
								if(timess==1){
									if(asign_num==1){
										if(asign_num1!='Z')
											k=asign_num1;
										else
											k=asign_num2;
										if((k!=0)&&(k!=2)){
											while(k>0){
                                 								if(k%2==0){
                                  									str="SHL";
                                   									v_bin.push_back(str);
                                   									k=k/2;
												}
                                  								else{
                                  									str="INC";
                                   									v_bin.push_back(str);
                                   									k=k-1;
								        			}
                                 							}
											kodProgramu.push_back("ZERO");
											numorders++;
											for(start=v_bin.size()-1;start>=0;start--){
												if(v_bin[start]=="INC"){
														if(msize6!='Z')
															kodProgramu.push_back("ADDI "+to_string(index_p2));
														else
															kodProgramu.push_back("ADD "+to_string(index_p2));
												}
												if(v_bin[start]=="SHL"){
														kodProgramu.push_back("SHL");
												}
												numorders++;
											}
											if(msize5!='Z')
												kodProgramu.push_back("STOREI "+to_string(index_p));
											else
												kodProgramu.push_back("STORE "+to_string(index_p));
											numorders++;
										}
										else{
											if(k==0){
												kodProgramu.push_back("ZERO");
												if(msize5!='Z')
													kodProgramu.push_back("STOREI "+to_string(index_p));
												else
													kodProgramu.push_back("STORE "+to_string(index_p));
												numorders=numorders+2;
											}
											if(k==2){
												if(msize6!='Z')
													kodProgramu.push_back("LOADI "+to_string(index_p2));
												else
													kodProgramu.push_back("LOAD "+to_string(index_p2));
												kodProgramu.push_back("SHL");
												if(msize5!='Z')
													kodProgramu.push_back("STOREI "+to_string(index_p));
												else
													kodProgramu.push_back("STORE "+to_string(index_p));
												numorders=numorders+3;
											}
										}
											
									}
									if(asign_num==0){
										msize=m_range;
										msize2=msize+1;	
										msize3=msize+2;
										kodProgramu.push_back("ZERO");
										kodProgramu.push_back("STORE "+to_string(msize3));
										if(msize6!='Z')
											kodProgramu.push_back("LOADI "+to_string(index_p2));
										else
											kodProgramu.push_back("LOAD "+to_string(index_p2));
										kodProgramu.push_back("STORE "+to_string(msize));
										if(msize7!='Z')
											kodProgramu.push_back("LOADI "+to_string(index_p3));
										else
											kodProgramu.push_back("LOAD "+to_string(index_p3));
										kodProgramu.push_back("STORE "+to_string(msize2));
										kodProgramu.push_back("LOAD "+to_string(msize2));
										kodProgramu.push_back("JZERO "+to_string(numorders+20));
										kodProgramu.push_back("JODD "+to_string(numorders+10));
										kodProgramu.push_back("JUMP "+to_string(numorders+13));
										kodProgramu.push_back("LOAD "+to_string(msize3));
										kodProgramu.push_back("ADD "+to_string(msize));
										kodProgramu.push_back("STORE "+to_string(msize3));
										kodProgramu.push_back("LOAD "+to_string(msize));
										kodProgramu.push_back("SHL");
										kodProgramu.push_back("STORE "+to_string(msize));
										kodProgramu.push_back("LOAD "+to_string(msize2));
										kodProgramu.push_back("SHR");
										kodProgramu.push_back("STORE "+to_string(msize2));
										kodProgramu.push_back("JUMP "+to_string(numorders+6));
										kodProgramu.push_back("LOAD "+to_string(msize3));
										if(msize5!='Z')
											kodProgramu.push_back("STOREI "+to_string(index_p));
										else
											kodProgramu.push_back("STORE "+to_string(index_p));
										numorders=numorders+22;
								 	}
								}
								if(divide==1){
									if(asign_num==1){
										if(asign_num1!='Z')
											k=asign_num1;
										else
											k=asign_num2;
										msize=m_range;
										msize2=msize+1;
										msize3=msize2+1;
										msize4=msize3+1;
										if((asign_num1=='Z')&&(asign_num2!=2)){
										        kodProgramu.push_back("ZERO");
											numorders++;
											liczba_bin();
											kodProgramu.push_back("STORE "+to_string(msize2));
											kodProgramu.push_back("ZERO");
											kodProgramu.push_back("STORE "+to_string(msize3));
											kodProgramu.push_back("LOAD "+to_string(msize2));
											kodProgramu.push_back("STORE "+to_string(msize4));
											kodProgramu.push_back("JZERO "+to_string(numorders+36));
											if(msize6!='Z')
												kodProgramu.push_back("LOADI "+to_string(index_p2));
											else
												kodProgramu.push_back("LOAD "+to_string(index_p2));
											kodProgramu.push_back("STORE "+to_string(msize));
											kodProgramu.push_back("LOAD "+to_string(msize));
											kodProgramu.push_back("INC");
											kodProgramu.push_back("SUB "+to_string(msize2));
											kodProgramu.push_back("JZERO "+to_string(numorders+16));
											kodProgramu.push_back("LOAD "+to_string(msize2));
											kodProgramu.push_back("SHL");
											kodProgramu.push_back("STORE "+to_string(msize2));
											kodProgramu.push_back("JUMP "+to_string(numorders+8));
											kodProgramu.push_back("LOAD "+to_string(msize2));
											kodProgramu.push_back("SUB "+to_string(msize));
											kodProgramu.push_back("JZERO "+to_string(numorders+23));
											kodProgramu.push_back("LOAD "+to_string(msize3));
											kodProgramu.push_back("SHL");
											kodProgramu.push_back("STORE "+to_string(msize3));
											kodProgramu.push_back("JUMP "+to_string(numorders+30));
											kodProgramu.push_back("LOAD "+to_string(msize));
											kodProgramu.push_back("SUB "+to_string(msize2));
											kodProgramu.push_back("STORE "+to_string(msize));
											kodProgramu.push_back("LOAD "+to_string(msize3));
											kodProgramu.push_back("SHL");
											kodProgramu.push_back("INC");
											kodProgramu.push_back("STORE "+to_string(msize3));
											kodProgramu.push_back("LOAD "+to_string(msize2));
											kodProgramu.push_back("SHR");
											kodProgramu.push_back("STORE "+to_string(msize2));
											kodProgramu.push_back("LOAD "+to_string(msize4));
											kodProgramu.push_back("SUB "+to_string(msize2));
											kodProgramu.push_back("JZERO "+to_string(numorders+16));
											kodProgramu.push_back("LOAD "+to_string(msize3));
											if(msize5!='Z')
												kodProgramu.push_back("STOREI "+to_string(index_p));
											else
												kodProgramu.push_back("STORE "+to_string(index_p));
											numorders=numorders+38;
										}
										if(asign_num1!='Z'){
											kodProgramu.push_back("ZERO");
											numorders++;
											liczba_bin();
											kodProgramu.push_back("STORE "+to_string(msize));
											if(msize6!='Z')
												kodProgramu.push_back("LOADI "+to_string(index_p2));
											else
												kodProgramu.push_back("LOAD "+to_string(index_p2));
											kodProgramu.push_back("JZERO "+to_string(numorders+32));
											kodProgramu.push_back("STORE "+to_string(msize2));
											kodProgramu.push_back("LOAD "+to_string(msize));
											kodProgramu.push_back("INC");
											kodProgramu.push_back("SUB "+to_string(msize2));
											kodProgramu.push_back("JZERO "+to_string(numorders+12));
											kodProgramu.push_back("LOAD "+to_string(msize2));
											kodProgramu.push_back("SHL");
											kodProgramu.push_back("STORE "+to_string(msize2));
											kodProgramu.push_back("JUMP "+to_string(numorders+4));
											kodProgramu.push_back("LOAD "+to_string(msize2));
											kodProgramu.push_back("SUB "+to_string(msize));
											kodProgramu.push_back("JZERO "+to_string(numorders+19));
											kodProgramu.push_back("LOAD "+to_string(msize3));
											kodProgramu.push_back("SHL");
											kodProgramu.push_back("STORE "+to_string(msize3));
											kodProgramu.push_back("JUMP "+to_string(numorders+26));
											kodProgramu.push_back("LOAD "+to_string(msize));
											kodProgramu.push_back("SUB "+to_string(msize2));
											kodProgramu.push_back("STORE "+to_string(msize));
											kodProgramu.push_back("LOAD "+to_string(msize3));
											kodProgramu.push_back("SHL");
											kodProgramu.push_back("INC");
											kodProgramu.push_back("STORE "+to_string(msize3));
											kodProgramu.push_back("LOAD "+to_string(msize2));
											kodProgramu.push_back("SHR");
											kodProgramu.push_back("STORE "+to_string(msize2));
											if(msize6!='Z')
												kodProgramu.push_back("LOADI "+to_string(index_p2));
											else
												kodProgramu.push_back("LOAD "+to_string(index_p2));
											kodProgramu.push_back("SUB "+to_string(msize2));
											kodProgramu.push_back("JZERO "+to_string(numorders+12));
											kodProgramu.push_back("LOAD "+to_string(msize3));
											if(msize5!='Z')
												kodProgramu.push_back("STOREI "+to_string(index_p));
											else
												kodProgramu.push_back("STORE "+to_string(index_p));
											numorders=numorders+34;
										}
										if(asign_num1=='Z'){
											if(asign_num2==2){
												if(msize6!='Z')
													kodProgramu.push_back("LOADI "+to_string(index_p2));
												else
													kodProgramu.push_back("LOAD "+to_string(index_p2));
												kodProgramu.push_back("SHR");
												if(msize5!='Z')
													kodProgramu.push_back("STOREI "+to_string(index_p));
												else
													kodProgramu.push_back("STORE "+to_string(index_p));
												numorders=numorders+3;
											}
										}
									}
									if(asign_num==0){
										msize=m_range;
										msize2=msize+1;
										msize3=msize2+1;
											kodProgramu.push_back("ZERO");
											kodProgramu.push_back("STORE "+to_string(msize3));
											if(msize7!='Z')
												kodProgramu.push_back("LOADI "+to_string(index_p3));
											else
												kodProgramu.push_back("LOAD "+to_string(index_p3));
											kodProgramu.push_back("JZERO "+to_string(numorders+35));
											kodProgramu.push_back("STORE "+to_string(msize2));
											if(msize6!='Z')
												kodProgramu.push_back("LOADI "+to_string(index_p2));
											else
												kodProgramu.push_back("LOAD "+to_string(index_p2));
											kodProgramu.push_back("STORE "+to_string(msize));
											kodProgramu.push_back("LOAD "+to_string(msize));
											kodProgramu.push_back("INC");
											kodProgramu.push_back("SUB "+to_string(msize2));
											kodProgramu.push_back("JZERO "+to_string(numorders+15));
											kodProgramu.push_back("LOAD "+to_string(msize2));
											kodProgramu.push_back("SHL");
											kodProgramu.push_back("STORE "+to_string(msize2));
											kodProgramu.push_back("JUMP "+to_string(numorders+7));
											kodProgramu.push_back("LOAD "+to_string(msize2));
											kodProgramu.push_back("SUB "+to_string(msize));
											kodProgramu.push_back("JZERO "+to_string(numorders+22));
											kodProgramu.push_back("LOAD "+to_string(msize3));
											kodProgramu.push_back("SHL");
											kodProgramu.push_back("STORE "+to_string(msize3));
											kodProgramu.push_back("JUMP "+to_string(numorders+29));
											kodProgramu.push_back("LOAD "+to_string(msize));
											kodProgramu.push_back("SUB "+to_string(msize2));
											kodProgramu.push_back("STORE "+to_string(msize));
											kodProgramu.push_back("LOAD "+to_string(msize3));
											kodProgramu.push_back("SHL");
											kodProgramu.push_back("INC");
											kodProgramu.push_back("STORE "+to_string(msize3));
											kodProgramu.push_back("LOAD "+to_string(msize2));
											kodProgramu.push_back("SHR");
											kodProgramu.push_back("STORE "+to_string(msize2));
											if(msize7!='Z')
												kodProgramu.push_back("LOADI "+to_string(index_p3));
											else
												kodProgramu.push_back("LOAD "+to_string(index_p3));
											kodProgramu.push_back("SUB "+to_string(msize2));
											kodProgramu.push_back("JZERO "+to_string(numorders+15));
											kodProgramu.push_back("LOAD "+to_string(msize3));
											if(msize5!='Z')
												kodProgramu.push_back("STOREI "+to_string(index_p));
											else
												kodProgramu.push_back("STORE "+to_string(index_p));
											numorders=numorders+37;
									}
								}
								if(modulo==1){
									if(asign_num==1){
										if(asign_num1!='Z')
											k=asign_num1;
										else
											k=asign_num2;
										msize=m_range;
										msize2=msize+1;
										msize4=msize+2;
										if((asign_num1=='Z')&&(asign_num2!=2)){
											kodProgramu.push_back("ZERO");
											numorders++;
											liczba_bin();
											kodProgramu.push_back("STORE "+to_string(msize2));
											kodProgramu.push_back("ZERO");
											kodProgramu.push_back("STORE "+to_string(msize));
											kodProgramu.push_back("LOAD "+to_string(msize2));
											kodProgramu.push_back("STORE "+to_string(msize4));
											kodProgramu.push_back("JZERO "+to_string(numorders+29));
											if(msize6!='Z')
												kodProgramu.push_back("LOADI "+to_string(index_p2));
											else
												kodProgramu.push_back("LOAD "+to_string(index_p2));
											kodProgramu.push_back("STORE "+to_string(msize));
											kodProgramu.push_back("LOAD "+to_string(msize));
											kodProgramu.push_back("INC");
											kodProgramu.push_back("SUB "+to_string(msize2));
											kodProgramu.push_back("JZERO "+to_string(numorders+16));
											kodProgramu.push_back("LOAD "+to_string(msize2));
											kodProgramu.push_back("SHL");
											kodProgramu.push_back("STORE "+to_string(msize2));
											kodProgramu.push_back("JUMP "+to_string(numorders+8));
											kodProgramu.push_back("LOAD "+to_string(msize2));
											kodProgramu.push_back("SUB "+to_string(msize));
											kodProgramu.push_back("JZERO "+to_string(numorders+20));
											kodProgramu.push_back("JUMP "+to_string(numorders+23));
											kodProgramu.push_back("LOAD "+to_string(msize));
											kodProgramu.push_back("SUB "+to_string(msize2));
											kodProgramu.push_back("STORE "+to_string(msize));
											kodProgramu.push_back("LOAD "+to_string(msize2));
											kodProgramu.push_back("SHR");
											kodProgramu.push_back("STORE "+to_string(msize2));
											kodProgramu.push_back("LOAD "+to_string(msize4));
											kodProgramu.push_back("SUB "+to_string(msize2));
											kodProgramu.push_back("JZERO "+to_string(numorders+16));
											kodProgramu.push_back("LOAD "+to_string(msize));
											if(msize5!='Z')
												kodProgramu.push_back("STOREI "+to_string(index_p));
											else
												kodProgramu.push_back("STORE "+to_string(index_p));
											numorders=numorders+31;
										}
										if(asign_num1!='Z'){
											kodProgramu.push_back("ZERO");
											numorders++;
											liczba_bin();
											kodProgramu.push_back("STORE "+to_string(msize));
											kodProgramu.push_back("ZERO");
											kodProgramu.push_back("STORE "+to_string(msize4));
											if(msize6!='Z')
												kodProgramu.push_back("LOADI "+to_string(index_p2));
											else
												kodProgramu.push_back("LOAD "+to_string(index_p2));
											kodProgramu.push_back("JZERO "+to_string(numorders+30));
											kodProgramu.push_back("STORE "+to_string(msize2));
											kodProgramu.push_back("LOAD "+to_string(msize));
											kodProgramu.push_back("INC");
											kodProgramu.push_back("SUB "+to_string(msize2));
											kodProgramu.push_back("JZERO "+to_string(numorders+14));
											kodProgramu.push_back("LOAD "+to_string(msize2));
											kodProgramu.push_back("SHL");
											kodProgramu.push_back("STORE "+to_string(msize2));
											kodProgramu.push_back("JUMP "+to_string(numorders+6));
											kodProgramu.push_back("LOAD "+to_string(msize2));
											kodProgramu.push_back("SUB "+to_string(msize));
											kodProgramu.push_back("JZERO "+to_string(numorders+18));
											kodProgramu.push_back("JUMP "+to_string(numorders+21));
											kodProgramu.push_back("LOAD "+to_string(msize));
											kodProgramu.push_back("SUB "+to_string(msize2));
											kodProgramu.push_back("STORE "+to_string(msize));
											kodProgramu.push_back("LOAD "+to_string(msize2));
											kodProgramu.push_back("SHR");
											kodProgramu.push_back("STORE "+to_string(msize2));
											if(msize6!='Z')
												kodProgramu.push_back("LOADI "+to_string(index_p2));
											else
												kodProgramu.push_back("LOAD "+to_string(index_p2));
											kodProgramu.push_back("SUB "+to_string(msize2));
											kodProgramu.push_back("JZERO "+to_string(numorders+14));
											kodProgramu.push_back("LOAD "+to_string(msize));
											kodProgramu.push_back("JUMP "+to_string(numorders+30));
											kodProgramu.push_back("LOAD "+to_string(msize4));
											if(msize5!='Z')
												kodProgramu.push_back("STOREI "+to_string(index_p));
											else
												kodProgramu.push_back("STORE "+to_string(index_p));
											numorders=numorders+31;
										}
										if(asign_num1=='Z'){
											if(asign_num2==2){
												if(msize6!='Z')
													kodProgramu.push_back("LOADI "+to_string(index_p2));
												else
													kodProgramu.push_back("LOAD "+to_string(index_p2));
												kodProgramu.push_back("SHR");
												kodProgramu.push_back("SHL ");
												kodProgramu.push_back("STORE "+to_string(msize));
												if(msize6!='Z')
													kodProgramu.push_back("LOADI "+to_string(index_p2));
												else
													kodProgramu.push_back("LOAD "+to_string(index_p2));
												kodProgramu.push_back("SUB "+to_string(msize));
												if(msize5!='Z')
													kodProgramu.push_back("STOREI "+to_string(index_p));
												else
													kodProgramu.push_back("STORE "+to_string(index_p));
												numorders=numorders+7;
											}
										}
									}
									if(asign_num==0){
										msize=m_range;
										msize2=msize+1;
											kodProgramu.push_back("ZERO");
											kodProgramu.push_back("STORE "+to_string(msize));
											if(msize7!='Z')
												kodProgramu.push_back("LOADI "+to_string(index_p3));
											else
												kodProgramu.push_back("LOAD "+to_string(index_p3));
											kodProgramu.push_back("JZERO "+to_string(numorders+28));
											kodProgramu.push_back("STORE "+to_string(msize2));
											if(msize6!='Z')
												kodProgramu.push_back("LOADI "+to_string(index_p2));
											else
												kodProgramu.push_back("LOAD "+to_string(index_p2));
											kodProgramu.push_back("STORE "+to_string(msize));
											kodProgramu.push_back("LOAD "+to_string(msize));
											kodProgramu.push_back("INC");
											kodProgramu.push_back("SUB "+to_string(msize2));
											kodProgramu.push_back("JZERO "+to_string(numorders+15));
											kodProgramu.push_back("LOAD "+to_string(msize2));
											kodProgramu.push_back("SHL");
											kodProgramu.push_back("STORE "+to_string(msize2));
											kodProgramu.push_back("JUMP "+to_string(numorders+7));
											kodProgramu.push_back("LOAD "+to_string(msize2));
											kodProgramu.push_back("SUB "+to_string(msize));
											kodProgramu.push_back("JZERO "+to_string(numorders+19));
											kodProgramu.push_back("JUMP "+to_string(numorders+22));
											kodProgramu.push_back("LOAD "+to_string(msize));
											kodProgramu.push_back("SUB "+to_string(msize2));
											kodProgramu.push_back("STORE "+to_string(msize));
											kodProgramu.push_back("LOAD "+to_string(msize2));
											kodProgramu.push_back("SHR");
											kodProgramu.push_back("STORE "+to_string(msize2));
											if(msize7!='Z')
												kodProgramu.push_back("LOADI "+to_string(index_p3));
											else
												kodProgramu.push_back("LOAD "+to_string(index_p3));
											kodProgramu.push_back("SUB "+to_string(msize2));
											kodProgramu.push_back("JZERO "+to_string(numorders+15));
											kodProgramu.push_back("LOAD "+to_string(msize));
											if(msize5!='Z')
												kodProgramu.push_back("STOREI "+to_string(index_p));
											else
												kodProgramu.push_back("STORE "+to_string(index_p));
											numorders=numorders+30;
									}





								}
							}
						}
						v_bin.clear();
						asign=0;
						asign_var=0;
						asign_num=0;
						asign_table=0;
}
	     | iff cond_th comm_els comm_endif{}
	     | iff cond_th comm_endif{}
	     | wh cond_do  comm_endwh{}
	     | fr pid from_val_to_val_do comm_endfor{}	
	     | fr pid from_val_downto_val_do comm_endfor{}	          
	     | R identifier SEMICOLON{
                              if(blad==0){
				   if(msize5!='Z')
					index_p=msize5;
				kodProgramu.push_back("GET");
				  if(msize5!='Z')
						kodProgramu.push_back("STOREI "+to_string(index_p));
				  else
						kodProgramu.push_back("STORE "+to_string(index_p));
				asign_var=asign_table=0;
				numorders=numorders+2;
				rd=0;
			      }
};
             | W value SEMICOLON{
					if(blad==0){
						   if(msize5!='Z')
							index_p=msize5;
						if(write_only_num==0){
							if(blad==0){
								if(msize5!='Z')
									kodProgramu.push_back("LOADI "+to_string(index_p));
				  				else
									kodProgramu.push_back("LOAD "+to_string(index_p));
								kodProgramu.push_back("PUT");
								numorders=numorders+2;
							}
					        }
						else{
							kodProgramu.push_back("ZERO");
							numorders++;
							k=write_num;
							liczba_bin();
							kodProgramu.push_back("PUT");
							numorders++;
						}
					}
					wr=0;
					write_only_num=0;
					asign_var=asign_table=0;
	}
;
R:        READ {if(blad==0)
			rd=1;
};
W:        WRITE{ if(blad==0)
			wr=1;
};
AS :      ASIGN    {if(blad==0){
				asign=1;
				pluss=minuss=timess=divide=modulo=0;
			   }
}
;
iff: IF{if(blad==0){
		number_of_line++;
		condition=1;
		condition_num1='Z';
		condition_num2='Z';
	}
}
;
cond_th : condition THEN{if(blad==0){
				jumpforward.push(numorders);
				kodProgramu.push_back(" ");
				numorders++;
			      }
}
;
comm_els :commands ELSE{if(blad==0){
				jumpforward_ed.push_back(make_pair(jumpforward.top(),numorders+1));
				jumpforward.pop();
				jumpforward.push(numorders);
				kodProgramu.push_back("JUMP");
				numorders++;
			}
}
;
comm_endif : commands ENDIF{if(blad==0){
				jumpforward_ed.push_back(make_pair(jumpforward.top(),numorders));
				jumpforward.pop();
				number_of_line++;
			    }
}
;
wh : WHILE{
		if(blad==0){
			if(loop==0)
				loop=1;
			number_of_line++;
			jumpbackward.push(numorders);
			condition=1;
			condition_num1='Z';
			condition_num2='Z';
		}
}
;
cond_do : condition DO {
		if(blad==0){
			jumpforward.push(numorders);
			kodProgramu.push_back(" ");
			numorders++;
		}
}
;
comm_endwh : commands ENDWHILE{
			if(blad==0){
				kodProgramu.push_back("JUMP "+to_string(jumpbackward.top()));
				numorders++;
				jumpforward_ed.push_back(make_pair(jumpforward.top(),numorders));
				jumpbackward.pop();
				jumpforward.pop();
				number_of_line++;
			}
};
fr: FOR{if(blad==0){    if(loop==0)
			loop=1;
		        number_of_line++;
			condition_num1='Z';
			condition_num2='Z';
		}
};
pid: pidentifier{
	 if(blad==0){
		zmienna=$1;
		j=0;
		znal=0;
		while((j<symbols.size())&&(znal==0)){
			if(symbols[j].first==zmienna){                     //sprawdzam identyfikator już nie występował jako zmienna				
				znal=1;
			}
			else
				j++;
		}
		if(znal==1){
			yyerror(("Blad w lini "+to_string(yylineno)+": "+"Druga deklaracja zmiennej: "+zmienna).c_str());
			blad=1;
		}
		j=0;
		znal=0;
		while((j<tables.size())&&(znal==0)){
			if(tables[j]==zmienna){                     //sprawdzam czy nazwa zmiennej nie jest nazwą tablicy				
				znal=1;
			}
			else
				j++;
		}
		if(znal==1){
			yyerror(("Blad w lini "+to_string(yylineno)+": "+"Niewłaściwe użycie zmiennej tablicowej: "+zmienna).c_str());
			blad=1;
		}
		i=0;
		znal=0;
		while((i<zmienna.length())&&(znal==0)){
			znak=zmienna[i];
			if(islower(znak)==0){
				blad=1;
				yyerror(("Blad w lini "+to_string(yylineno)+": "+"Nierozpoznany napis: "+zmienna).c_str());
				znal=1;
			}
		i++;
		}
		symbols.push_back(make_pair(zmienna,1)); //dodaje identyfikator do zmiennych
		index_p=m_range;
		m_range++;   
		idfor.push(index_p);   //wkładam na stos adres iteratora pętli
		condition=1; 
         }
};
from_val_to_val_do:FROM value TO value DO{
		msize8=m_range+8;
		if(blad==0){rodzajfor.push("TO");
			     if(msize5!='Z')
				index_p=msize5;
			     if(msize6!='Z')
				index_p2=msize6;
			if(condition_num==2){
				kodProgramu.push_back("ZERO");
				numorders++;
				k=condition_num1;
				liczba_bin();
				kodProgramu.push_back("STORE "+to_string(idfor.top()));
				numorders++;
				kodProgramu.push_back("ZERO");
				numorders++;
				k=condition_num2;
				liczba_bin();
				kodProgramu.push_back("STORE "+to_string(msize8));   //zachowuje do kiedy pętla się ma obracać pod msize8
				numorders++;
			}
			if(condition_num==1){
				if(condition_num1!='Z'){
					kodProgramu.push_back("ZERO");
					numorders++;
					k=condition_num1;
					liczba_bin();
					kodProgramu.push_back("STORE "+to_string(idfor.top()));   //podstawiam val pod iterator
					numorders++;
					if(msize5!='Z')
						kodProgramu.push_back("LOADI "+to_string(index_p));
				 	else
						kodProgramu.push_back("LOAD "+to_string(index_p));  //zachowuje do kiedy pętla się ma obracać pod msize8
					kodProgramu.push_back("STORE "+to_string(msize8));
					numorders=numorders+2;
				}
				else{
					if(msize5!='Z')
						kodProgramu.push_back("LOADI "+to_string(index_p));
					else
						kodProgramu.push_back("LOAD "+to_string(index_p));
					kodProgramu.push_back("STORE "+to_string(idfor.top()));
					numorders=numorders+2;
					kodProgramu.push_back("ZERO");
					numorders++;
					k=condition_num2;
					liczba_bin();
					kodProgramu.push_back("STORE "+to_string(msize8));   //zachowuje do kiedy pętla się ma obracać pod msize8
					numorders++;
				}
			}
			if(condition_num==0){
				  if(msize5!='Z')
					kodProgramu.push_back("LOADI "+to_string(index_p));
				  else
					kodProgramu.push_back("LOAD "+to_string(index_p));
				kodProgramu.push_back("STORE "+to_string(idfor.top()));
				numorders=numorders+2;
				 if(msize6!='Z')
					kodProgramu.push_back("LOADI "+to_string(index_p2));
				  else
					kodProgramu.push_back("LOAD "+to_string(index_p2));
				 kodProgramu.push_back("STORE "+to_string(msize8));   //zachowuje do kiedy pętla się ma obracać pod msize8
				 numorders=numorders+2;	
			}
			jumpbackward.push(numorders);
			msize=m_range;
			if(condition_num==2){									//teraz robię warunek SMEQUAL ale porownuje z msize8
				kodProgramu.push_back("LOAD "+to_string(msize8)); 
				kodProgramu.push_back("INC");
				kodProgramu.push_back("SUB "+to_string(idfor.top()));
				numorders=numorders+3;
			}
			if(condition_num==1){
				if(condition_num1!='Z'){
					kodProgramu.push_back("LOAD "+to_string(msize8));
					kodProgramu.push_back("INC");
					kodProgramu.push_back("SUB "+to_string(idfor.top()));
					numorders=numorders+3;
				}					
				else{
					kodProgramu.push_back("LOAD "+to_string(msize8));
					kodProgramu.push_back("INC");
					kodProgramu.push_back("SUB "+to_string(idfor.top()));
					numorders=numorders+3;
				}
			 }
				    if(condition_num==0){
					kodProgramu.push_back("LOAD "+to_string(msize8));
					kodProgramu.push_back("INC");
					kodProgramu.push_back("SUB "+to_string(idfor.top()));
					numorders=numorders+3;
				     }
				     condition=0;
				     asign_var=asign_table=0;
				     condition_var=condition_num=0;
				     jumpforward.push(numorders);
				     kodProgramu.push_back(" ");
				     numorders++;
			}
};
from_val_downto_val_do : FROM value DOWNTO value DO{
			msize8=m_range+8;
			if(blad==0){rodzajfor.push("DOWNTO");
				if(msize5!='Z')
				index_p=msize5;
			     if(msize6!='Z')
				index_p2=msize6;
			if(condition_num==2){
				kodProgramu.push_back("ZERO");
				numorders++;
				k=condition_num1;
				liczba_bin();
				kodProgramu.push_back("STORE "+to_string(idfor.top()));
				numorders++;
				kodProgramu.push_back("ZERO");
				numorders++;
				k=condition_num2;
				liczba_bin();
				kodProgramu.push_back("STORE "+to_string(msize8));   //zachowuje do kiedy pętla się ma obracać pod msize8
				numorders++;
			}
			if(condition_num==1){
			if(condition_num1!='Z'){
					kodProgramu.push_back("ZERO");
					numorders++;
					k=condition_num1;
					liczba_bin();
					kodProgramu.push_back("STORE "+to_string(idfor.top()));   //podstawiam val pod iterator
					numorders++;
					if(msize5!='Z')
						kodProgramu.push_back("LOADI "+to_string(index_p));
				 	else
						kodProgramu.push_back("LOAD "+to_string(index_p));  //zachowuje do kiedy pętla się ma obracać pod msize8
					kodProgramu.push_back("STORE "+to_string(msize8));
					numorders=numorders+2;
				}
				else{
					if(msize5!='Z')
						kodProgramu.push_back("LOADI "+to_string(index_p));
					else
						kodProgramu.push_back("LOAD "+to_string(index_p));
					kodProgramu.push_back("STORE "+to_string(idfor.top()));
					numorders=numorders+2;
					kodProgramu.push_back("ZERO");
					numorders++;
					k=condition_num2;
					liczba_bin();
					kodProgramu.push_back("STORE "+to_string(msize8));   //zachowuje do kiedy pętla się ma obracać pod msize8
					numorders++;
				}
			}
			if(condition_num==0){
				 if(msize5!='Z')
					kodProgramu.push_back("LOADI "+to_string(index_p));
				  else
					kodProgramu.push_back("LOAD "+to_string(index_p));
				kodProgramu.push_back("STORE "+to_string(idfor.top()));
				numorders=numorders+2;
				 if(msize6!='Z')
					kodProgramu.push_back("LOADI "+to_string(index_p2));
				  else
					kodProgramu.push_back("LOAD "+to_string(index_p2));
				 kodProgramu.push_back("STORE "+to_string(msize8));   //zachowuje do kiedy pętla się ma obracać pod msize8
				 numorders=numorders+2;
			}
			jumpbackward.push(numorders);
			msize=m_range;
			if(condition_num==2){									//teraz robię warunek SMEQUAL
				kodProgramu.push_back("LOAD "+to_string(idfor.top()));
				kodProgramu.push_back("INC");
				kodProgramu.push_back("SUB "+to_string(msize8));
				numorders=numorders+3;
			}
			if(condition_num==1){
				if(condition_num1!='Z'){
					kodProgramu.push_back("LOAD "+to_string(idfor.top()));
					kodProgramu.push_back("INC");
					kodProgramu.push_back("SUB "+to_string(msize8));
					numorders=numorders+3;
				}					
				else{
					kodProgramu.push_back("LOAD "+to_string(idfor.top()));
					kodProgramu.push_back("INC");
					kodProgramu.push_back("SUB "+to_string(msize8));
					numorders=numorders+3;
				}
			 }
				    if(condition_num==0){
					kodProgramu.push_back("LOAD "+to_string(idfor.top()));
					kodProgramu.push_back("INC");
					kodProgramu.push_back("SUB "+to_string(msize8));
					numorders=numorders+3;
				     }
				     condition=0;
				     asign_var=asign_table=0;
				     condition_var=condition_num=0;
				     jumpforward.push(numorders);
				     kodProgramu.push_back(" ");
				     numorders++;
			}
};
comm_endfor: commands ENDFOR{if(blad==0){
				if(rodzajfor.top()=="TO"){
					kodProgramu.push_back("LOAD "+to_string(idfor.top()));
					kodProgramu.push_back("INC");					//zwiększam identyfikator o 1
					kodProgramu.push_back("STORE "+to_string(idfor.top()));
					kodProgramu.push_back("JUMP "+to_string(jumpbackward.top()));
					numorders=numorders+4;
				}
				else{
					kodProgramu.push_back("LOAD "+to_string(idfor.top()));
					kodProgramu.push_back("JZERO "+to_string(numorders+5));   //gdy identifikator zjedzie do zera to musimy zakończyć pętlę
					kodProgramu.push_back("DEC");
					kodProgramu.push_back("STORE "+to_string(idfor.top()));  //zmniejszam iterator o jeden
					kodProgramu.push_back("JUMP "+to_string(jumpbackward.top()));
					numorders=numorders+5;
				}
				jumpforward_ed.push_back(make_pair(jumpforward.top(),numorders));
				jumpbackward.pop();
				jumpforward.pop();
				rodzajfor.pop();
				idfor.pop();
				m_range--; 
				pom.clear();                        //pozbywam się identyfikatora z symbols i memory
				for(i=0;i<symbols.size()-1;i++)
					pom.push_back(symbols[i]);
				symbols.clear();
				for(i=0;i<pom.size();i++)
					symbols.push_back(pom[i]);
				number_of_line++;
			   }
};
expression  : value
             | value PLUS value{pluss=1;}
             | value MINUS value{minuss=1;}
             | value TIMES value{timess=1;}
             | value DIVIDE value{divide=1;}
             | value MODULO value{modulo=1;}
;
condition   : value EQUAL value  { msize=m_range;
				   msize2=msize+1;
				   msize3=msize2+1;
				   msize4=msize3+1;
				   if(msize5!='Z')
					index_p=msize5;
				   if(msize6!='Z')
					index_p2=msize6;
				   if(blad==0){
				   if(condition_num==2){
				   	kodProgramu.push_back("ZERO");
					numorders++;
					k=condition_num1;
					liczba_bin();
					kodProgramu.push_back("STORE "+to_string(msize));   
					k=condition_num2;
					kodProgramu.push_back("ZERO");
					numorders=numorders+2;
					liczba_bin();
					kodProgramu.push_back("STORE "+to_string(msize2));
					kodProgramu.push_back("LOAD "+to_string(msize2));
					kodProgramu.push_back("SUB "+to_string(msize));
					kodProgramu.push_back("STORE "+to_string(msize3));
					kodProgramu.push_back("LOAD "+to_string(msize));
					kodProgramu.push_back("SUB "+to_string(msize2));
					kodProgramu.push_back("ADD "+to_string(msize3));
					kodProgramu.push_back("STORE "+to_string(msize4));
					kodProgramu.push_back("ZERO");
					kodProgramu.push_back("INC");
					kodProgramu.push_back("SUB "+to_string(msize4));
					numorders=numorders+11;
				 }
			         if(condition_num==1){
					if(condition_num1!='Z')
						k=condition_num1;
					else
						k=condition_num2;
					kodProgramu.push_back("ZERO");
					numorders++;
					liczba_bin();
					kodProgramu.push_back("STORE "+to_string(msize)); 
				        if(msize5!='Z')
						kodProgramu.push_back("LOADI "+to_string(index_p));
					else
						kodProgramu.push_back("LOAD "+to_string(index_p));
					kodProgramu.push_back("SUB "+to_string(msize));
					kodProgramu.push_back("STORE "+to_string(msize2));
					kodProgramu.push_back("LOAD "+to_string(msize));
					if(msize5!='Z')
						kodProgramu.push_back("SUBI "+to_string(index_p));
					else
						kodProgramu.push_back("SUB "+to_string(index_p));
					kodProgramu.push_back("ADD "+to_string(msize2));
					kodProgramu.push_back("STORE "+to_string(msize3));
					kodProgramu.push_back("ZERO");
					kodProgramu.push_back("INC");
					kodProgramu.push_back("SUB "+to_string(msize3));
					numorders=numorders+11;
				}
				if(condition_num==0){
					if(msize6!='Z')
						kodProgramu.push_back("LOADI "+to_string(index_p2));
					else
						kodProgramu.push_back("LOAD "+to_string(index_p2));
					if(msize5!='Z')
						kodProgramu.push_back("SUBI "+to_string(index_p));
					else
						kodProgramu.push_back("SUB "+to_string(index_p));
			   		kodProgramu.push_back("STORE "+to_string(msize));
					if(msize5!='Z')
						kodProgramu.push_back("LOADI "+to_string(index_p));
					else
						kodProgramu.push_back("LOAD "+to_string(index_p));
					if(msize6!='Z')
						kodProgramu.push_back("SUBI "+to_string(index_p2));
					else
						kodProgramu.push_back("SUB "+to_string(index_p2));
					kodProgramu.push_back("ADD "+to_string(msize));
					kodProgramu.push_back("STORE "+to_string(msize2));
					kodProgramu.push_back("ZERO");
					kodProgramu.push_back("INC");
					kodProgramu.push_back("SUB "+to_string(msize2));
					numorders=numorders+10;
				}
		}
		condition=0;
		asign_var=asign_table=0;
		condition_var=condition_num=0;
	}
             | value NEQUAL value {msize=m_range;
				   msize2=msize+1;
				   msize3=msize2+1;
				    if(msize5!='Z')
					index_p=msize5;
				   if(msize6!='Z')
					index_p2=msize6;
				   if(blad==0){
				   if(condition_num==2){
				   	kodProgramu.push_back("ZERO");
					numorders++;
					k=condition_num1;
					liczba_bin();
					kodProgramu.push_back("STORE "+to_string(msize));   
					k=condition_num2;
					kodProgramu.push_back("ZERO");
					numorders=numorders+2;
					liczba_bin();
					kodProgramu.push_back("STORE "+to_string(msize2));
					kodProgramu.push_back("LOAD "+to_string(msize));
					kodProgramu.push_back("SUB "+to_string(msize2));
					kodProgramu.push_back("STORE "+to_string(msize3));
					kodProgramu.push_back("LOAD "+to_string(msize2));
					kodProgramu.push_back("SUB "+to_string(msize));
					kodProgramu.push_back("ADD "+to_string(msize3));
					numorders=numorders+7;
				 }
			         if(condition_num==1){
					if(condition_num1!='Z')
						k=condition_num1;
					else
						k=condition_num2;
					kodProgramu.push_back("ZERO");
					numorders++;
					liczba_bin();
					kodProgramu.push_back("STORE "+to_string(msize)); 
				        kodProgramu.push_back("LOAD "+to_string(msize));
					if(msize5!='Z')
						kodProgramu.push_back("SUBI "+to_string(index_p));
					else
						kodProgramu.push_back("SUB "+to_string(index_p));
					kodProgramu.push_back("STORE "+to_string(msize2));
					if(msize5!='Z')
						kodProgramu.push_back("LOADI "+to_string(index_p));
					else
						kodProgramu.push_back("LOAD "+to_string(index_p));
					kodProgramu.push_back("SUB "+to_string(msize));
					kodProgramu.push_back("ADD "+to_string(msize2)); 
					numorders=numorders+7;
				}
				if(condition_num==0){
					if(msize5!='Z')
						kodProgramu.push_back("LOADI "+to_string(index_p));
					else
						kodProgramu.push_back("LOAD "+to_string(index_p));
					if(msize6!='Z')
						kodProgramu.push_back("SUBI "+to_string(index_p2));
					else
						kodProgramu.push_back("SUB "+to_string(index_p2));
			   		kodProgramu.push_back("STORE "+to_string(msize));
					if(msize6!='Z')
						kodProgramu.push_back("LOADI "+to_string(index_p2));
					else
						kodProgramu.push_back("LOAD "+to_string(index_p2));
					if(msize5!='Z')
						kodProgramu.push_back("SUBI "+to_string(index_p));
					else
						kodProgramu.push_back("SUB "+to_string(index_p));
					kodProgramu.push_back("ADD "+to_string(msize));
					numorders=numorders+6;
				}
		}
		condition=0;
		asign_var=asign_table=0;
		condition_var=condition_num=0;
}
             | value SMALLER value  {msize=m_range;
				     msize2=msize+1;
				     msize3=msize2+1;
				      if(msize5!='Z')
					index_p=msize5;
				   if(msize6!='Z')
					index_p2=msize6;
				     if(blad==0){
				     if(condition_num==2){
				     	kodProgramu.push_back("ZERO");
					numorders++;
					k=condition_num1;
					liczba_bin();
					kodProgramu.push_back("STORE "+to_string(msize));  
					kodProgramu.push_back("ZERO");
					numorders=numorders+2;
					k=condition_num2;
					liczba_bin();
					kodProgramu.push_back("SUB "+to_string(msize));
					numorders++;
				     }
				     if(condition_num==1){
					if(condition_num1!='Z')
						k=condition_num1;
					else
						k=condition_num2;
					kodProgramu.push_back("ZERO");
					numorders++;
					liczba_bin();
					if(condition_num1!='Z'){
						kodProgramu.push_back("STORE "+to_string(msize));  
						if(msize5!='Z')
							kodProgramu.push_back("LOADI "+to_string(index_p));
						else
							kodProgramu.push_back("LOAD "+to_string(index_p));
						kodProgramu.push_back("SUB "+to_string(msize));
						numorders=numorders+3;
					}
					else{
						if(msize5!='Z')
							kodProgramu.push_back("SUBI "+to_string(index_p));
						else
							kodProgramu.push_back("SUB "+to_string(index_p));
						numorders++;
					}
				     }
				     if(condition_num==0){
					if(msize6!='Z')
						kodProgramu.push_back("LOADI "+to_string(index_p2));
					else
						kodProgramu.push_back("LOAD "+to_string(index_p2));
					if(msize5!='Z')
						kodProgramu.push_back("SUBI "+to_string(index_p));
					else
						kodProgramu.push_back("SUB "+to_string(index_p));
					numorders=numorders+2;
				     }
				     condition=0;
				   }
			asign_var=asign_table=0;
			condition_var=condition_num=0;
}
						
             | value GRATTER value  {msize=m_range;
				     msize2=msize+1;
				     msize3=msize2+1;
				      if(msize5!='Z')
					index_p=msize5;
				   if(msize6!='Z')
					index_p2=msize6;
				     if(blad==0){
				     if(condition_num==2){
				     	kodProgramu.push_back("ZERO");
					numorders++;
					k=condition_num2;
					liczba_bin();
					kodProgramu.push_back("STORE "+to_string(msize));  
					kodProgramu.push_back("ZERO");
					numorders=numorders+2;
					k=condition_num1;
					liczba_bin();
					kodProgramu.push_back("SUB "+to_string(msize));
					numorders++;
				     }
				     if(condition_num==1){
					if(condition_num1!='Z')
						k=condition_num1;
					else
						k=condition_num2;
					kodProgramu.push_back("ZERO");
					numorders++;
					liczba_bin();
					if(condition_num1!='Z'){
						if(msize5!='Z')
							kodProgramu.push_back("SUBI "+to_string(index_p));
						else
							kodProgramu.push_back("SUB "+to_string(index_p));
						numorders++;
					}
					else{
						kodProgramu.push_back("STORE "+to_string(msize));  
						if(msize5!='Z')
							kodProgramu.push_back("LOADI "+to_string(index_p));
						else
							kodProgramu.push_back("LOAD "+to_string(index_p));
						kodProgramu.push_back("SUB "+to_string(msize));
						numorders=numorders+3;
					}
				     }
				     if(condition_num==0){
					if(msize5!='Z')
						kodProgramu.push_back("LOADI "+to_string(index_p));
					else
						kodProgramu.push_back("LOAD "+to_string(index_p));
					if(msize6!='Z')
						kodProgramu.push_back("SUBI "+to_string(index_p2));
					else
						kodProgramu.push_back("SUB "+to_string(index_p2));
					numorders=numorders+2;
				     }
				     condition=0;
				   }
				asign_var=asign_table=0;
				condition_var=condition_num=0;
}
             | value SMEQUAL value {msize=m_range;
				     msize2=msize+1;
				     msize3=msize2+1;
				      if(msize5!='Z')
					index_p=msize5;
				   if(msize6!='Z')
					index_p2=msize6;
				     if(blad==0){
				     if(condition_num==2){
				     	kodProgramu.push_back("ZERO");
					numorders++;
					k=condition_num1;
					liczba_bin();
					kodProgramu.push_back("STORE "+to_string(msize));
					kodProgramu.push_back("ZERO");
   					numorders=numorders+2;
					k=condition_num2;
					liczba_bin();
					kodProgramu.push_back("INC");
					kodProgramu.push_back("SUB "+to_string(msize));
					numorders=numorders+2;
				     }
				     if(condition_num==1){
					if(condition_num1!='Z')
						k=condition_num1;
					else
						k=condition_num2;
					kodProgramu.push_back("ZERO");
					numorders++;
					liczba_bin();
					if(condition_num1!='Z'){
						kodProgramu.push_back("STORE "+to_string(msize));
						if(msize5!='Z')
							kodProgramu.push_back("LOADI "+to_string(index_p));
						else
							kodProgramu.push_back("LOAD "+to_string(index_p));
						kodProgramu.push_back("INC");
 						kodProgramu.push_back("SUB "+to_string(msize));
						numorders=numorders+4;
					}
					else{
						kodProgramu.push_back("INC");
						if(msize5!='Z')
							kodProgramu.push_back("SUBI "+to_string(index_p));
						else
							kodProgramu.push_back("SUB "+to_string(index_p));
						numorders=numorders+2;
					}
				     }
				     if(condition_num==0){
					if(msize6!='Z')
						kodProgramu.push_back("LOADI "+to_string(index_p2));
					else
						kodProgramu.push_back("LOAD "+to_string(index_p2));
					kodProgramu.push_back("INC");
					if(msize5!='Z')
						kodProgramu.push_back("SUBI "+to_string(index_p));
					else
						kodProgramu.push_back("SUB "+to_string(index_p));
					numorders=numorders+3;
				     }
				     condition=0;
				   }
			asign_var=asign_table=0;
			condition_var=condition_num=0;
}
             | value GTEQUAL value {msize=m_range;
				     msize2=msize+1;
				     msize3=msize2+1;
				      if(msize5!='Z')
					index_p=msize5;
				   if(msize6!='Z')
					index_p2=msize6;
				     if(blad==0){
				     if(condition_num==2){
				     	kodProgramu.push_back("ZERO");
					numorders++;
					k=condition_num2;
					liczba_bin();
					kodProgramu.push_back("STORE "+to_string(msize));
					kodProgramu.push_back("ZERO");  
					numorders=numorders+2;
					k=condition_num1;
					liczba_bin();
					kodProgramu.push_back("INC");
					kodProgramu.push_back("SUB "+to_string(msize));
					numorders=numorders+2;
				     }
				     if(condition_num==1){
					if(condition_num1!='Z')
						k=condition_num1;
					else
						k=condition_num2;
					kodProgramu.push_back("ZERO");
					numorders++;
					liczba_bin();
					if(condition_num1!='Z'){
						kodProgramu.push_back("INC");
						if(msize5!='Z')
							kodProgramu.push_back("SUBI "+to_string(index_p));
						else
							kodProgramu.push_back("SUB "+to_string(index_p));
						numorders=numorders+2;
					}
					else{
						kodProgramu.push_back("STORE "+to_string(msize));
						if(msize5!='Z')
							kodProgramu.push_back("LOADI "+to_string(index_p));
						else
							kodProgramu.push_back("LOAD "+to_string(index_p));
						kodProgramu.push_back("INC");
 						kodProgramu.push_back("SUB "+to_string(msize));
						numorders=numorders+4;
					}
				     }
				     if(condition_num==0){
					if(msize5!='Z')
						kodProgramu.push_back("LOADI "+to_string(index_p));
					else
						kodProgramu.push_back("LOAD "+to_string(index_p));
					kodProgramu.push_back("INC");
					if(msize6!='Z')
						kodProgramu.push_back("SUBI "+to_string(index_p2));
					else
						kodProgramu.push_back("SUB "+to_string(index_p2));
					numorders=numorders+3;
				     }
				     condition=0;
				   }
				asign_var=asign_table=0;
				condition_var=condition_num=0;
}
;
value       : num  {
		    if(blad==0){
			write_only_num=1;
                        write_num=atoi($1.c_str());
			if(asign==1){
				if(asign_num==0){
					if(asign_var+asign_table==1)
						asign_num1=atoi($1.c_str());
					if(asign_var+asign_table==2){
						asign_num2=atoi($1.c_str());
						asign_num1='Z';
					}
				}	
				else
				    	asign_num2=atoi($1.c_str());
				asign_num++;
			}
			if(condition==1){
					if((condition_var==1)||(condition_num==1)){
						condition_num2=atoi($1.c_str());
						if(condition_num==0)
							condition_num1='Z';
					}
					else
						condition_num1=atoi($1.c_str());
			condition_num++;
			}
			if(write_num<0){
				yyerror(("Blad w lini "+to_string(yylineno)+": "+"Niewłaściwy znak: '-' ").c_str());
				blad=1;
			}
		    }
}
             | identifier{
				write_only_num=0;
}
;
identifier  : pidentifier{index_temp=0;
                           if(blad==0){
				if(asign==0){
					asign_var++;
					number_of_line++;
					if(condition==0)
				        	msize5='Z';
				}
				i=0;
                                znal=0;
                                zmienna=$1;
				write_arg=$1;
                                while((i<symbols.size())&&(znal==0)){
					if(zmienna==symbols[i].first)
						znal=1;
					i++;
				}
				if(znal==0){
					yyerror(("Blad w lini "+to_string(yylineno)+": "+"Niezadeklarowana zmienna: "+zmienna).c_str());
					blad=1;
				}                        				
                                if(blad==0){
			        	znal=0;
					i=0;
					while((i<tables.size())&&(znal==0)){
						if(tables[i]==zmienna)                     //sprawdzam czy nazwa zmiennej nie jest nazwą tablicy
							znal=1;
						i++;
					}
					if(znal==1){
						yyerror(("Blad w lini "+to_string(yylineno)+": "+"Niewłaściwe użycie zmiennej tablicowej: "+zmienna).c_str());
						blad=1;
					}
					if(blad==0){
						if(((asign==1)&&((asign_var>=1)||(asign_table>=1)))||(condition==1))
							index_temp=index_p;
						index_p=0;
						i=0;
						while(zmienna!=symbols[i].first){
							index_p=index_p+symbols[i].second;
							i++;
						}
						if(asign==1){
							if(asign_var+asign_table==1){
								asign_var++;
								index_p2=index_p;
								index_p=index_temp;
								msize6='Z';
							}
							else{
								if(asign_var+asign_table==2){
									asign_var++;
									index_p3=index_p;
									index_p=index_temp;
									msize7='Z';
			
					   	 	}	}
						}
						if(condition==1){
							if(condition_var==1){
								index_p2=index_p;
								index_p=index_temp;
								msize6='Z';
							}
							if(condition_var==0)
								msize5='Z';
							condition_var++;
						}
					}
				}
			}
}				
             | pidentifier LSQB pidentifier RSQB{ index_temp=0;
						int wart_el_tab,adres_el;
						if(blad==0){
							if(asign==0){
								asign_table++;
								number_of_line++;
							}
							i=0;
							znal=0;
			                        	znal2=0;
                                                	zmienna=$1;
                                                	zmienna2=$3;
							write_arg=$1+"["+$3+"]";
							while((i<symbols.size())&&((znal==0)||(znal2==0))){
								if(zmienna==symbols[i].first){
									znal=1;
								}							
								else{
									if(zmienna2==symbols[i].first)
										znal2=1;
								}
								i++;
							}
							if(znal==0){
								yyerror(("Blad w lini "+to_string(yylineno)+": "+"Niezadeklarowana zmienna: "+zmienna).c_str());
								blad=1;
							}
							if(blad==0){
								if(znal2==0){
									yyerror(("Blad w lini "+to_string(yylineno)+": "+"Niezadeklarowana zmienna: "+zmienna2).c_str());	
						        		blad=1;
								}
							}
							if(blad==0){
								i=0;
								znal=0;
								znal2=0;                                      //sprawdzam czy zmienna 1 jest nazwą tablicy i czy zmienna2 nie jest zmienną tablicy
								while(i<tables.size()){
									if(tables[i]==zmienna)
										znal=1;
									if(tables[i]==zmienna2)
										znal2=1;
									i++;
								}
								if(znal==0){
									yyerror(("Blad w lini "+to_string(yylineno)+": "+"Niewłaściwe użycie zmiennej "+zmienna).c_str());
									blad=1;
								}
								if(blad==0){
									if(znal2==1){
										yyerror(("Blad w lini "+to_string(yylineno)+": "+"Niewłaściwe użycie zmiennej tablicowej "+zmienna2).c_str());
										blad=1;
									}
								}
							}
							if(blad==0){
								if(((asign==1)&&((asign_var>=1)||(asign_table>=1)))||(condition==1)){
							        	 index_temp=index_p;
									 adres_el_tab=adres_el_tab_temp;
								}
								i=0;
								index_p=0;
  								znal=0;
								znal2=0;
								adres_el_tab=0;
								adres_el=0;
								while((i<symbols.size())&&((znal==0)||(znal2==0))){
									if(zmienna==symbols[i].first){
										znal=1;
										wymiar=symbols[i].second;
										if(znal2==0)
											adres_el_tab=adres_el_tab+wymiar;
									}
									else{
										if(zmienna2==symbols[i].first){
											wart_el_tab=1;
											znal2=1;
											if(znal==0)
												index_p=index_p+symbols[i].second;
										}
										else{
											if(znal==0)
												index_p=index_p+symbols[i].second;
											if(znal2==0)
												adres_el_tab=adres_el_tab+symbols[i].second;
										}
									}
									if(znal2==0)
										adres_el=adres_el+symbols[i].second;
									i++;
								}
								if(blad==0){
									if(((asign==1)||(asign==0))&&(condition==0)){
										if((asign_var+asign_table==1)&&(asign>=1)){
											msize6=m_range+6;
											asign_table++;
											index_p2=index_p;
											index_p=index_temp;
											adres_el_tab2=adres_el_tab;
											adres_el_tab=adres_el_tab_temp;
											kodProgramu.push_back("LOAD "+to_string(adres_el_tab2));
											kodProgramu.push_back("STORE "+to_string(msize6));
											kodProgramu.push_back("ZERO");
											numorders=numorders+3;
											k=index_p2;
											liczba_bin();
											kodProgramu.push_back("ADD "+to_string(msize6));
											kodProgramu.push_back("STORE "+to_string(msize6));
											numorders=numorders+2;
										}
										else{
											if(asign_var+asign_table==2){
												msize7=m_range+7;
												asign_table++;
												index_p3=index_p;
												index_p=index_temp;
												adres_el_tab3=adres_el_tab;
												adres_el_tab=adres_el_tab_temp;
												kodProgramu.push_back("LOAD "+to_string(adres_el_tab3));
												kodProgramu.push_back("STORE "+to_string(msize7));
												kodProgramu.push_back("ZERO");
												numorders=numorders+3;
												k=index_p3;
												liczba_bin();
												kodProgramu.push_back("ADD "+to_string(msize7));
												kodProgramu.push_back("STORE "+to_string(msize7));
												numorders=numorders+2;
					   	 					}else{
													msize5=m_range+5;
													kodProgramu.push_back("LOAD "+to_string(adres_el_tab));
													kodProgramu.push_back("STORE "+to_string(msize5));
													kodProgramu.push_back("ZERO");
													numorders=numorders+3;
													k=index_p;
													liczba_bin();
													kodProgramu.push_back("ADD "+to_string(msize5));
													kodProgramu.push_back("STORE "+to_string(msize5));
													numorders=numorders+2;
											    }
										}
									}
									if(condition==1){
										if(condition_var==1){
											msize6=m_range+6;
											index_p2=index_p;
											index_p=index_temp;
											adres_el_tab2=adres_el_tab;
											adres_el_tab=adres_el_tab_temp;
											kodProgramu.push_back("LOAD "+to_string(adres_el_tab2));
											kodProgramu.push_back("STORE "+to_string(msize6));
											kodProgramu.push_back("ZERO");
											numorders=numorders+3;
											k=index_p2;
											liczba_bin();
											kodProgramu.push_back("ADD "+to_string(msize6));
											kodProgramu.push_back("STORE "+to_string(msize6));
											numorders=numorders+2;
										}
										if(condition_var==0){
												msize5=m_range+5;
												kodProgramu.push_back("LOAD "+to_string(adres_el_tab));
												kodProgramu.push_back("STORE "+to_string(msize5));
												kodProgramu.push_back("ZERO");
												numorders=numorders+3;
												k=index_p;
												liczba_bin();
												kodProgramu.push_back("ADD "+to_string(msize5));
												kodProgramu.push_back("STORE "+to_string(msize5));
												numorders=numorders+2;
										}
										condition_var++;
									}
								}
							}
                                             }
}
             | pidentifier LSQB num RSQB{if(blad==0){
						if(asign==0){
							asign_table++;
							number_of_line++;
							if(condition==0)
								msize5='Z';
						}
						index_temp=0;
						i=0;
						znal=0;
                                                zmienna=$1;
						write_arg=$1+"["+$3+"]";
						while((i<symbols.size())&&(znal==0)){
							if(zmienna==symbols[i].first){
								znal=1;
								wymiar=symbols[i].second;
							}
							i++;
						}
						if(znal==0){
							yyerror(("Blad w lini "+to_string(yylineno)+": "+"Niezadeklarowana zmienna: "+zmienna).c_str());
							blad=1;
						}
						if(blad==0){
							i=0;
							znal=0;
							while((i<tables.size())&&(znal==0)){                       //sprawdzam czy zmienna jest nazwą tablicy
								if(tables[i]==zmienna)
              								znal=1;
								i++;
							}
							if(znal==0){
								yyerror(("Blad w lini "+to_string(yylineno)+": "+"Niewłaściwe użycie zmiennej "+zmienna).c_str());
								blad=1;
							}
						}
                                                index_el=atoi($3.c_str());
                                                if(blad==0){
                                                	if((index_el<0)||(index_el>=wymiar)){if(loop==0){
								yyerror(("Blad w lini "+to_string(yylineno)+": "+"Indeks poza zakresem tablicy: "+to_string(index_el)).c_str());
								blad=1;}
							}
						}
						if(blad==0){
							if(((asign==1)&&((asign_var>=1)||(asign_table>=1)))||(condition==1))
							        	index_temp=index_p;
							i=0;
							index_p=0;
							znal=0;
							while((i<symbols.size())&&(znal==0)){               //Szukam indeksu indentifiera w pamięci
								if(zmienna==symbols[i].first){
									znal=1;
									index_p=index_p+index_el;
								}
								else{
 									index_p=index_p+symbols[i].second;
									i++;
								}
							}
							if(asign==1){
								if(asign_var+asign_table==1){
									asign_table++;
									index_p2=index_p;
									index_p=index_temp;
									msize6='Z';
								}
								else{
									if(asign_var+asign_table==2){
										asign_table++;
										index_p3=index_p;
										index_p=index_temp;
										msize7='Z';
									}
					   	 		}
							}
							if(condition==1){
								if(condition_var==1){
									index_p2=index_p;
									index_p=index_temp;
									msize6='Z';
								}
								if(condition_var==0)
									msize5='Z';
								condition_var++;
							}		
						}
					}
}
;
%%
void yyerror(const char* s){
  cout<<s<<endl;
}
int main(int argc, char* argv[]) {
   	yyparse();
	if(blad==0)
	{
		for(i=0;i<jumpforward_ed.size();i++){
			if(kodProgramu[jumpforward_ed[i].first]=="JUMP")
				kodProgramu[jumpforward_ed[i].first]="JUMP "+to_string(jumpforward_ed[i].second);
			else
				kodProgramu[jumpforward_ed[i].first]="JZERO "+to_string(jumpforward_ed[i].second);
		}
		for(i=0;i<kodProgramu.size();i++)
			cout<<kodProgramu[i]<<endl;
	}
}














