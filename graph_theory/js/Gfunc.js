"use strict";
var global_option=0;  //opcja do wyświetlania kroków algorytmów
class Gfunc {
    constructor(noOfVertices)
    {
        this.noOfVertices = noOfVertices;
        this.AdjList = new Map();
        this.data=[];
        this.first_set=[];         //first_set i second_set - tablice na dwa zbiory w grafie dwudzielnym
        this.second_set=[];
	this.EdgesWeight = new Map(); //struktura-mapa , przechowuje wagi krawędzi w grafie ważonym
    }

    //funkcja addVertex dodaje wierzchołki do grafu,ustawiając listę sąsiadów dla każdego wierzchołka na pustą
    addVertex(v){
   	 this.AdjList.set(v, []);
    }
    //funkcja tworząca losowy graf prosty
    createRandomplaingraph(){
        var p=0;
    	for(var i=0;i<this.noOfVertices;i++){
	    for(var k=0;k<i;k++){
		var list=this.AdjList.get(k);
		var znaleziony=0;
		var l=0;
		while((l<list.length)&&(znaleziony==0)){
			if(list[l]==i){
				znaleziony=1;
				this.AdjList.get(i).push(k);
			}
			l++;
		}
	    }
            for(var j=i+1;j<this.noOfVertices;j++){
		p=Math.floor(Math.random()*100);
                if(p>50){
			this.AdjList.get(i).push(j);
                }
            }
        }
     }
     //funkcja tworząca losowy pełny graf
     createRandomfullgraph(){
        for(var i=0;i<this.noOfVertices-1;i++){
            for(var j=0;j<this.noOfVertices;j++){
			this.AdjList.get(i).push(j);
            }
        }
     }
     //funkcja dodająca wagi do krawędzi w grafie ważonym
     addweigthstoEdges(){
     	for(var i=0;i<this.noOfVertices;i++){
		this.EdgesWeight.set(i,[]);
		for(var j=0;j<this.noOfVertices;j++){
			this.EdgesWeight.get(i).push(0);
		}
	}
	for(var i=0;i<this.noOfVertices;i++){
		var list=this.AdjList.get(i);
		for(var l=0;l<list.length;l++){
			if(list[l]>i){
			var p=Math.floor((Math.random()*10)+1);
			this.EdgesWeight.get(i)[list[l]]=p;
			}
			else{
				this.EdgesWeight.get(i)[list[l]]=this.EdgesWeight.get(list[l])[i];
			}
		}
	}
      }
     //funkcja przekształcająca listę sąsiedztwa w strukturę potrzebną do skontruowania rysunku grafu
     graphtodata(T,option){
      this.data=[];
      if(option==0){
	global_option=0;
        for(var i=0;i<this.noOfVertices;i++){
          var list=this.AdjList.get(i);
	  if(list.length>0){
          for(var j in list){
              var neigh=list[j];
	      if(i<neigh){
              	this.data.push(i);
              	this.data.push(neigh);
	      }
          }
	 }
        }
       }
       else{//wizualizacja przykładu algorytmu prima lub dijkstry
		global_option=1;
		for(var i=0;i<T.length;i++){
			this.data.push(T[i].x);
			this.data.push(T[i].y);
		}
	}
     }
     //function ustawiająca tekst do przykładu w pierwszej lekcji
     setExampleTextplaingraph(context){
       var text="Zbiór wierzchołków powyższego grafu to:";
       for(var i=0;i<this.noOfVertices;i++){
		text=text+" v"+String(i+1);
       }
      text=text+". Zbiór krawędzi powyższego grafu to:";
      for(var i=0;i<this.noOfVertices;i++){
        var list=this.AdjList.get(i);
        for(var j in list){
		if(list[j]>i){
			text=text+" (v"+String(i+1)+"-v"+String(list[j]+1)+")"
		}
        }
     }
      context[0].innerHTML=text+".";
   }
   //funkcja ustawiająca tekst do przykładu pełnego grafu
   setExampleTextfullgraph(context){
     var text="Powyższy graf jest grafem pełnym: każde dwa wierzchołki grafu są sąsiednie";
      context[0].innerHTML=text+".";
    }
    //funkcja ustawiająca tekst do przykładu dwudzielnego grafu
    setExampledualgraph(context){
     var text="Powyższy graf jest grafem dwudzielnym: można go podzielić na dwa zbiory V1: ";
     for(var i=0;i<this.first_set.length;i++){
         	text=text+"v"+String(this.first_set[i]+1)+" ";
     }
     text=text+"i V2:";
     for(var i=0;i<this.second_set.length;i++){
         	text=text+" v"+String(this.second_set[i]+1);
     }
     text=text+", każda krawędź grafu łączy wierzchołek ze zbioru V1 z wierzchołkiem ze zbioru V2";
     context[0].innerHTML=text+".";
    }
    //funkcja ustawiająca tekst do przykładu spójnego grafu
    setExampleconsistgraph(context){
	var text="Powyższy graf jest grafem spójnym - nie da się go przedstawić jako sumy dwóch grafów.";
        context[0].innerHTML=text;
    }
    //funkcja ustawiająca tekst do przykładu drogi
    setExampleTextroute(context){
	var text="Przykładem drogi w powyższym grafie jest ciąg wierzchołków: ";
        var v=Math.floor(Math.random()*this.noOfVertices);
        text=text+"v"+String(v+1)+" ";
        var vert_on_route=[];             //wierzchołki na drodze
	var znaleziony=0;
        while(znaleziony==0){
		vert_on_route.push(v);
		var list=this.AdjList.get(v);
		if(list.length==0){
			znaleziony=1;
                }
		else{
		     var v2=list[Math.floor(Math.random()*list.length)];
		     var znaleziony2=0;
		     var j=0;
		     while((j<vert_on_route.length)&&(znaleziony2==0)){
		     	if(vert_on_route[j]==v2){
				znaleziony2=1;
			}		
		     	j++;
		     }
		     if(znaleziony2==1){
		     	znaleziony=1;
		     }
		     else{
			text=text+"v"+String(v2+1)+" ";
			v=v2;
		     }
		}
	}
        context[0].innerHTML=text+".";
    }
    //funkcja ustawiająca tekst do przykładu cyklicznego grafu
    setExampleTextcycle(context){
	var text="Powyższy graf jest grafem cyklicznym - posiada przynajmniej jeden cykl.";
	context[0].innerHTML=text;
    }
    //funckja ustawiająca tekst do przykładu grafu Eulera
    setExampleTextEulercycle(context){
	var text="Powyższy graf jest grafem eulerowskim - posiada cykl Eulera.";
	context[0].innerHTML=text;
    }
    //funckcja ustawiająca tekst do przykładu drzewa
     setExampleTextTree(context){
	var text="Powyższy graf jest drzewem.";
	context[0].innerHTML=text;
    }
    //funkcja znajdująca mosty używająca algorytmu Tarjana
      DFSb(v,vf,Graph,D,cv){
      	D[v]=cv;
	var Low=cv;
	cv=cv+1;
	for(var u=0;u<this.noOfVertices;u++){
		if(Graph[v][u]!=0){
			if(u!=vf){
				if(D[u]==0){
					var temp=this.DFSb(u,v,Graph,D,cv);
					if(temp<Low){
						Low=temp;
					}
				}
				else{
				   if(D[u]<Low){
					Low=D[u];
				   }
				}
			}
		}
	}
	if((vf>-1)&&(Low==D[v])){
		Graph[vf][v]=2;
		Graph[v][vf]=2;
	}
	return Low;
    }
    //funkcja ustawiająca tekst do przykładu algorytmu fleury'ego
    setExampleTextFleuryalg(ctx,ctx2){
	//najpierw tworzymy kopię grafu jako macierz sąsiedztwa
	var Adjmatrix=new Array(this.noOfVertices);
	for(var i=0;i<this.noOfVertices;i++){
		Adjmatrix[i]=new Array(this.noOfVertices);
		for(var j=0;j<this.noOfVertices;j++){
			Adjmatrix[i][j]=0;
		}
	}
	for(var i=0;i<this.noOfVertices;i++){
		var list=this.AdjList.get(i);
        	for(var j in list){
			if(i<list[j]){
			Adjmatrix[i][list[j]]=1;
			Adjmatrix[list[j]][i]=1;
			}
		}
	}
        //teraz wybieramy wierzchołek startowy-pierwszy wierzchołek o niezerowym stopniu
	var znaleziony=0;
	var i=0;
	while(znaleziony==0){
		var list=this.AdjList.get(i);
		if(list.length>=1){
			znaleziony=1;
		}
		else{
			i++;
		}
	}
	//wyświetlam zerowy krok przykładu
	var text="Wierzchołek startowy to: v"+String(i+1)+".";
	this.graphtodata(0,0);
	visual(ctx[0],this.data,this.noOfVertices);
	ctx2[0].innerHTML=text;
	var c=0;
		
	var v=i;
	var u=0;
	var D=[];
	for(var i=0;i<this.noOfVertices;i++){
		D.push(0);                                  //zerujemy tablicę D
	}
        var S=[];                                          //stos na wierzchołki cyklu
	var neigrboor=1;
	while(neigrboor==1){
		S.push(v);                                     //wkładamy v na stos
		neigrboor=0;
		var j=0;
		while((j<this.noOfVertices)&&(neigrboor==0)){
			if(Adjmatrix[v][j]!=0){
				neigrboor=1;
				 u=j;          //pierwszy sąsiad v
			}
			j++;
		}
		if(neigrboor==1){                        //v ma sąsiada
			for(var i=0;i<this.noOfVertices;i++){
				D[i]=0;                                  //zerujemy tablicę D
			}
			var cv=1;
			this.DFSb(v,-1,Adjmatrix,D,cv);  //oznaczamy mosty
			var exist=1;
			while((Adjmatrix[v][u]==2)&&(exist==1)){  //szukamy pierwszej krawędzi która nie jest mostem
		        	exist=0;
				var k=u+1;                             
				while((k<this.noOfVertices)&&(exist==0)){
					if(Adjmatrix[v][k]!=0){
						exist=1;                       
					}
					else{
						k++;
					}
				}
				if(exist==1){  //istnieje inna krawędź
					u=k;	
				}
			}
			Adjmatrix[v][u]=0;     //usuwamy krawędź v-u z grafu
			Adjmatrix[u][v]=0;
			//wizualizujemy krok przykładu algorytmu
			var Pom=new Map();
			for(var i=0;i<this.noOfVertices;i++){
				Pom.set(i, []);
				var list=this.AdjList.get(i);       //usuwamy z AdjList krawędź v-u
				for(j=0;j<list.length;j++){
					var blad=0;
					if(((i==v)&&(list[j]==u))||((i==u)&&(list[j]==v))){
						blad=1;
					}
					if(blad==0){
						Pom.get(i).push(list[j]);
					}
				}		
			}
			this.AdjList=Pom;
			c++;
			var cs=String(c);
			this.graphtodata(0,0);
			visual(ctx[c],this.data,this.noOfVertices);
			text="Usuwamy krawędź v"+String(v+1)+"-v"+String(u+1)+" i dodajemy ją do cyklu Eulera.";
			if(c==ctx2.length-1){
				text=text+" Cykl Eulera w tym grafie jest następujący: "; 
				while(S.length>=1){
					var s=S.pop();
					text=text+"v"+String(s+1)+" ";
				}
				ctx2[c].innerHTML=text+".";
			}
			else{
				ctx2[c].innerHTML=text;
			}
			v=u;     //przechodzimy do wierzchołka u
		}
	}
      }
     //funkcja ustawiająca tekst do przykładu algorytmu dijkstry
     setExampleTextDijkstraalg(ctx,ctx2,ctx3){
	var weight_of_edges="Wagi krawędzi w  grafie są następujące: ";
	for(var i=0;i<this.noOfVertices-1;i++){
		var list=this.EdgesWeight.get(i);
		for(var j=i+1;j<list.length;j++){
			if(list[j]!=0){
				weight_of_edges=weight_of_edges+"v"+String(i+1)+"-v"+String(j+1)+"("+String(list[j])+") ";
			}
		}
	}
	//wyświetlam zerowy krok przykładu
	ctx3[0].innerHTML=weight_of_edges;
	var text="Wierzchołek startowy to: v1.";
	this.graphtodata(0,0);
        visual(ctx[0],this.data,this.noOfVertices);
	ctx2[0].innerHTML=text;
	var c=0;
	//koniec wyświetlania przykładu
	var T=[];    //pomocnicza struktura do drzewa najkrótszych ścieżek
	var Update=[];//zrelaksowane wierzchołki
	var v=0;
	var d=[];
	d.push(0);
	for(var i=0;i<this.noOfVertices-1;i++){             //przygotowanie tablicy d
		d.push(200000);
	}
	var p=[];
	for(var i=0;i<this.noOfVertices;i++){              //przygotowujemy tablicę p
		p.push(-1);
	}
	var Q=[];
	for(var i=0;i<this.noOfVertices;i++){               //przygotowuje zbiór Q
		Q.push(i);
	}
	while(Q.length>=1){
		Update=[];
		T=[];
		var minimum=d[Q[0]];
		var minind=0;
		for(var i=0;i<Q.length;i++){
			if(d[Q[i]]<=minimum){
				minimum=d[Q[i]];
				minind=i;
			}
		}                         //wyznaczamy ze zbioru Q element o minimalnej wartości d[i]
		v=Q[minind];
		text=text+"v"+String(v+1)+" ";
		Q.splice(minind,1);
		var list=this.AdjList.get(v);
		for(var j=0;j<list.length;j++){        //sprawdzamy każdego sąsiada v
			var u=list[j];
			var znaleziony=0;
			var k=0;
			while((k<Q.length)&&(znaleziony==0)){
				if(Q[k]==u){
					znaleziony=1;
				}                               //sprawdzamy czy sąsiad jest w Q
				k++;
			}
			if(znaleziony==1){
				var w=this.EdgesWeight.get(v)[u];
				if(d[u]>(d[v]+w)){
					Update.push(u);
					d[u]=d[v]+w;
					p[u]=v;
				}
			}
		}
		//wyświetlanie kolejnego kroku przykładu
		c++;
	        if(Update.length==0){
			text="Najkrótsza scieżka do żadnego z wierchołków nie uległa zmianie";
		}
		else{
			text="Najkrótsza ścieżka do wierzchołków";
			for(var i=0;i<Update.length;i++){
				text=text+" v"+String(Update[i]+1)	
			}
			text=text+" uległa zmianie";
		}
		for(var i=1;i<=d.length;i++){
			if(d[i]<200000){
				var v1=i;
				while(v1!=0){
					var v2=p[v1];
					T.push({x:v1,y:v2});     //tworzenie drzewa najkrótszych ścieżek
					v1=v2;
				}
			}
		}
		text=text+". Tablica d ma postać:"
		for(var i=0;i<d.length;i++){
			text=text+" v"+String(i+1)+"-"+String(d[i]);
		}
		text=text+". Tablica p ma postać:"
		for(var i=1;i<p.length;i++){
			if(p[i]>=0){
				text=text+" v"+String(i+1)+"-v"+String(p[i]+1);
			}
			else{
				text=text+" v"+String(i+1)+"- -1";
			}
		}
		var cs=String(c);
		this.graphtodata(T,1);
		visual(ctx[c],this.data,this.noOfVertices);
		ctx2[c].innerHTML=text+".";
		ctx3[c].innerHTML=weight_of_edges;
		//koniec wizualizacji kolejnego kroku przykładu
	}
    }
    //funckcja ustawiająca tekst do przykładu algorytmu Prima
    setExampleTextPrim(ctx,ctx2,ctx3){
	var n=this.noOfVertices;
	var weight_of_edges="Wagi krawędzi w  grafie są następujące: ";
	for(var i=0;i<this.noOfVertices-1;i++){
		var list=this.EdgesWeight.get(i);
		for(var j=i+1;j<list.length;j++){
			if(list[j]!=0){
				weight_of_edges=weight_of_edges+"v"+String(i+1)+"-v"+String(j+1)+"("+String(list[j])+") ";
			}
		}
	}
	var Q=new Map();        //zbiór krawędzi grafu z wagami
	for(var i=0;i<this.noOfVertices;i++){
		Q.set(i,[]);
		for(var j=0;j<this.noOfVertices;j++){
			Q.get(i).push(0);
		}
	}
	var T=[];                //zbiór w którym powstanie minimalne drzewo rozpinające grafu
	var visited=[];
	for(var i=0;i<this.noOfVertices;i++){
		visited.push("F");
	}
	var v=0;
	visited[v]="T";
	var u;
	var text="Wierzchołek startowy to: v1."
	//wyświetlam zerowy krok przykładu
	this.graphtodata(0,0);
	visual(ctx[0],this.data,this.noOfVertices);
	ctx2[0].innerHTML=text;
	ctx3[0].innerHTML=weight_of_edges;
	var c=0;

	for(var k=0;k<n-1;k++){
		var list=this.AdjList.get(v);
		for(var j=0;j<list.length;j++){
			u=list[j];
			if(visited[u]=="F"){
				Q.get(v)[u]=this.EdgesWeight.get(v)[u];
			}
		}
			var minimum=2000;
			var min_i=0;
			var min_j=0;
			var i=0;
			while(i<this.noOfVertices){
				for(j=0;j<this.noOfVertices;j++){
					if(Q.get(i)[j]!=0){
						if(Q.get(i)[j]<=minimum){
							minimum=Q.get(i)[j];
							min_i=i;
							min_j=j;
						}
					}
				}
				i++;
			}
			Q.get(min_i)[min_j]=0;
			while(visited[min_j]=="T"){
				 minimum=2000;
				 min_i=0;
				 min_j=0;
				 i=0;
				while(i<this.noOfVertices){
					for(j=0;j<this.noOfVertices;j++){
						if(Q.get(i)[j]!=0){
							if(Q.get(i)[j]<=minimum){
								minimum=Q.get(i)[j];
								min_i=i;
								min_j=j;
							}
						}
					}
					i++;
				}
				Q.get(min_i)[min_j]=0;
			}
			v=min_i;
			u=min_j;
			T.push({x:v,y:u});
			//wizualizacja kolejnego kroku algorytmu prima
			c++;
			var cs=String(c);
			this.graphtodata(T,1);
			visual(ctx[c],this.data,this.noOfVertices);
			text="Do minimalnego drzewa rozpinającego zostaje dodana krawędź v"+String(v+1)+"-v"+String(u+1)+".";
			if(c==ctx2.length-1){
				text=text+"Minimalne drzewo rozpinające powyższego grafu to: ";
				for(var i=0;i<T.length;i++){
					text=text+"(v"+String(T[i].x+1)+"-v"+String(T[i].y+1)+") ";
				}
				ctx2[c].innerHTML=text+".";
			}
			else{
				ctx2[c].innerHTML=text;
			}
			ctx3[c].innerHTML=weight_of_edges;
			//koniec wizualizacji

			visited[u]="T";
			v=u;
	}
    }

    //funkcja sprawdzająca czy graf jest dwudzielny
    checkdual(){
        var dualny=1;
        var i=0;
        while((i<this.noOfVertices-1)&&(dualny==1)){
		var list=this.AdjList.get(i);
                var fv1=0;
		var fv2=0;
		var sv1=0;
		var sv2=0;
		var j=0;
		var znaleziony=0;
		while((j<list.length)&&(znaleziony==0)){
			fv1=0;
			fv2=0;
			sv1=0;
			sv2=0;
			var k=0;
			var znalezione=0;
			while((k<this.first_set.length)&&(znalezione!=2)){
				if(this.first_set[k]==i){
					fv1=1;
				        znalezione++;
				}
				if(this.first_set[k]==list[j]){
					fv2=1;
				        znalezione++;
				}
				k++;
			}
			k=0;
			while((k<this.second_set.length)&&(znalezione!=2)){
				if(this.second_set[k]==i){
					sv1=1;
				        znalezione++;
				}
				if(this.second_set[k]==list[j]){
					sv2=1;
				        znalezione++;
				}
				k++;
			}
			if(znalezione==0){
				this.first_set.push(i);
				this.second_set.push(list[j]);
			}
			else{
				if(znalezione==2){
					if((fv1==fv2)||(sv1==sv2)){
						znaleziony=1;
					}
				}
				if(znalezione==1){
					if(fv1==1){
						this.second_set.push(list[j]);
					}
					if(fv2==1){
						this.second_set.push(i);
					}
					if(sv1==1){
						this.first_set.push(list[j]);
					}
					if(sv2==1){
						this.first_set.push(i);
					}
				}
			}
			j++;
		}
		if(znaleziony==1){
			dualny=0;
		}
		i++;
         }
	 for(var i=0;i<this.noOfVertices;i++){
		var list=this.AdjList.get(i);
		if(list.length==0){
			this.second_set.push(i);
		}
	}
         if(dualny==1){
            return 1;
         }
         else{
           return 0;
         }
    }
   //funkcja sprawdzająca czy graf jest spójny
   checkcons(){
   	var visited=[];     //tablica odwiedzonych wierzchołków
        var S=[];            //stos na wierzchołki
        var n=this.noOfVertices;            //liczba wierzchołków grafu
        for(var i=0;i<this.noOfVertices;i++){
                   visited.push("F");
        }
         var k=0;
          visited[k]="T";
          S.push(k);
          var counter=0;
          while(S.length>=1){
 		var v=S.pop();
                counter++;
                var list=this.AdjList.get(v);
                for(var j in list){
			if(visited[list[j]]=="F"){
                           visited[list[j]]="T";
			   S.push(list[j]);
			}
               }
          }
          if(counter==n){
              return 1;
          }
          else{
               return 0;
          }
 }
 //funkcja sprawdzająca czy graf ma cykl Eulera
 check_euler_cycle(){
	var znaleziony=0;
	var i=0;
	while((i<this.noOfVertices)&&(znaleziony==0)){
		var list=this.AdjList.get(i);                 //szukam pierwszego wierzchołka o stopniu niezerowym
		if(list.length>=1){
			znaleziony=1;
		}
		else{
                	i++;
		}
	}
	if(znaleziony==0){
		return 0;                       //jeśli nie ma takiego wierzchołka graf nie ma cyklu Eulera
	}
	var visited=[];
	var n=this.noOfVertices;
	for(var j=0;j<n;j++){
		visited.push("F");
	}
	var S=[];
	var no=0;                        //licznik wierzchołków o nieparzystym stopniu
	S.push(i);
	visited[i]="T";                 //wierzchołek i jest odwiedzony
	while(S.length>=1){
		 var v=S.pop();                                        //startujemy DFS ,aby sprawdzić czy graf jest spójny i wyznaczyć stopnie wierzchołków
		 var nc=0;                                            //zerujemy licznik sąsiadów wierzchołka
		 var list=this.AdjList.get(v);                      //tworzymy listę sąsiadów danego wierzchołka
		 for(var j in list){                               //przeglądamy sąsiadów wierzchołka v
			var u=list[j];
			nc++;
			if(visited[u]=="F"){
				visited[u]="T";
				S.push(u);
			}
		}
		if(nc%2==1){
			no++;
		}
	}		
	for(var v=i+1;v<n;v++){
		var neigrboor=0;
		var list=this.AdjList.get(v);
		if(list.length>=1){
			neigrboor=1;                      //sprawdzamy czy v ma sąsiada
		}
		if((visited[v]=="F")&&(neigrboor==1)){          //sprawdzamy czy graf jest spójny(z pominięciem wierzchołków o stopniu 0)
			return 0;                                  
		}
	}	
	if(no==0){
		return 1;          //graf ma cykl eulera
	}
	if(no==2){
		return 0;
	}
	return 0;
}
  //funkcja sprawdzająca czy graf jet cykliczny	
  check_cycle(){
        var n=this.noOfVertices;            //liczba wierzchołków grafu
	var visited=[];     //tablica odwiedzonych wierzchołków
        for(var i=0;i<n;i++){
                   visited.push("F");
        }
	for(var i=0;i<n;i++){
		if(visited[i]=="F"){
			if(this.isComponentCyclic(i,visited)==1){
				return 1;
			}
                }
	}
	return 0;
   }
   //mała funkcja używana w funkcji check_cycle
   isComponentCyclic(i,visited){
	var S=[];            //stos na wierzchołki
 	S.push(i);
        S.push(-1);
        visited[i]="T";
	while(S.length>=1){
		var w=S.pop();
		i=S.pop();
		var list=this.AdjList.get(i);             //tworzymy listę sąsiadów danego wierzchołka
		for(var j in list){
			var z=list[j];
			if(visited[z]=="F"){
				S.push(z);
				S.push(i);
				visited[z]="T";
			}
			else{
				if(z!=w){
					return 1;
				}
			}
	       }
	}
	return 0;
   }
   //funkcja sprawdzająca czy użytkownik poprawnie podał cykl
   check_cycle_good(str){
	var vertices=str.split(" ");
        var i=0;
        var znaleziony=1;
        if(vertices.length<4){
		alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
	}
        while((i<vertices.length-1)&&(znaleziony==1)){
		if(vertices[i].length!=2){
			alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
		}
                var v=vertices[i].substr(1,2)-1;
		var v2=vertices[i+1].substr(1,2)-1;
		var znaleziony2=0;
		var list=this.AdjList.get(v);
                var j=0;
                while((j<list.length)&&(znaleziony2==0)){
			if(list[j]==v2){
				znaleziony2=1;
			}
			j++;
		}
	       if(v==v2){
			alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
		}
	       i++;
               if(znaleziony2==0){
			znaleziony=0;
	       }
        }
        if((znaleziony==1)&&(vertices[0]==vertices[vertices.length-1])){
		alert("Gratulacje! Ćwiczenie zostało wykonane w sposób prawidłowy.");
        }
        else{
		alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
        }
   }
   //funkcja sprawdzająca ćwiczenie w pierwszej lekcji
   check(str){
      var spl=str.split(".");
      if(spl.length!=2){
		alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");          //sprawdzamy wyjątki dla użytkownika
      }
      else{
           if((spl[0].length==0)||(spl[1].length==0)){
		alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
           }
      }
      var ok_vert=0;        // wierzchołki się zgadzają
      var ok_edges=0;       // krawędzie się zgadzają
      var vpom=spl[0];
      var vertices=vpom.split(" ");
      if(vertices.length<2){
		alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");          //sprawdzamy wyjątki dla użytkownika
      }
      var znaleziony=1;
      var i=0;
      var vert_number=0;                 //liczba wierzchołków grafu
      var edg_number=0;                  //liczba krawędzi grafu
      //sprawdzanie wierzchołków grafu
      for(var i=0;i<this.noOfVertices;i++){
	 var j=0;
         znaleziony=0;
         while((j<vertices.length)&&(znaleziony==0)){
	   if(vertices[j].length!=2){
		alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");         //sprawdzamy wyjątki dla użytkownika
	   }
           if(vertices[j].substr(1,2)==String(i+1)){
                znaleziony=1;
           }
           j++;
         }     
     }
     if((znaleziony==1)&&(vertices.length==this.noOfVertices)){
		 ok_vert=1;
     }
     // sprawdzenie krawędzi
     var vpom2=spl[1];
     var edges=vpom2.split(" ");
     if(edges.length<2){
		alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");          //sprawdzamy wyjątki dla użytkownika
      }
     i=0;
     znaleziony=1;
     while((i<this.noOfVertices)&&(znaleziony==1)){
     	var list=this.AdjList.get(i);
        if(list.length>=1){
        	var j=0;
                var znaleziony2=1;
                while((j<list.length)&&(znaleziony2==1)){
			if(i<list[j]){
			var k=0;
                        var znaleziony3=0;
                        while((k<edges.length)&&(znaleziony3==0)){
                              var fv=edges[k].split("-")[0];
         		      if(fv.length!=2){
				alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");          //sprawdzamy wyjątki dla użytkownika
      			      }
                              var fvn=fv.substr(1,2);
                              var sv=edges[k].split("-")[1];
			      if(sv.length!=2){
				alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");          //sprawdzamy wyjątki dla użytkownika
      			      }
                              var svn=sv.substr(1,2);
                              if((String(fvn)==i+1)&&(String(svn)==(list[j]+1))){
                                    znaleziony3=1;
                              }
                              k++;
                       }
                       if(znaleziony3==0){
                             znaleziony2=0;
                       }
		        edg_number++;
		       }
                       j++;
                 }
           }
           if(znaleziony2==0){
		znaleziony=0;
           }
           i++;
     }
     if((znaleziony==1)&&(edg_number==edges.length)){
         ok_edges=1;
     }
     if((ok_vert==1)&&(ok_edges==1)){
          alert("Gratulacje! Ćwiczenie zostało wykonane w sposób prawidłowy.");
     }
     else{
          alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
     }
   }
   //funkcja sprawdzająca ćwiczenie z algorytmu fleury'ego
   check_fleury(str){
	//najpierw tworzymy kopię grafu jako macierz sąsiedztwa
	var Adjmatrix=new Array(this.noOfVertices);
	for(var i=0;i<this.noOfVertices;i++){
		Adjmatrix[i]=new Array(this.noOfVertices);
		for(var j=0;j<this.noOfVertices;j++){
			Adjmatrix[i][j]=0;
		}
	}
	for(var i=0;i<this.noOfVertices;i++){
		var list=this.AdjList.get(i);
        	for(var j in list){
			if(i<list[j]){
			Adjmatrix[i][list[j]]=1;
			Adjmatrix[list[j]][i]=1;
			}
		}
	}
	var spl=str.split(",");
        if((spl.length!=3)||(spl[0].length!=2)){
		alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");           //wyjątki użytkowników
	}
	var v_start=spl[0].substr(1,2)-1; 
	var znaleziony=0;                                  //sprawdzam czy użytkownik wybrał za wierzchołek startowy wierzcholek o niezerowym stopniu
	var i=0;
	while((i<this.noOfVertices)&&(znaleziony==0)){
		if(Adjmatrix[v_start][i]==1){
			znaleziony=1;
		}
		else{
			i++;
		}
	}
	if(znaleziony==0){
		alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
	}
	var v=v_start;
	var u=0;
	var D=[];
	for(var i=0;i<this.noOfVertices;i++){
		D.push(0);                                  //zerujemy tablicę D
	}
        var S=[];                                          //stos na wierzchołki cyklu
	var neigrboor=1;
	while(neigrboor==1){
		S.push(v);                                     //wkładamy v na stos
		neigrboor=0;
		var j=0;
		while((j<this.noOfVertices)&&(neigrboor==0)){
			if(Adjmatrix[v][j]!=0){
				neigrboor=1;
				 u=j;          //pierwszy sąsiad v
			}
			j++;
		}
		if(neigrboor==1){                        //v ma sąsiada
			for(var i=0;i<this.noOfVertices;i++){
				D[i]=0;                                  //zerujemy tablicę D
			}
			var cv=1;
			this.DFSb(v,-1,Adjmatrix,D,cv);  //oznaczamy mosty
			var exist=1;
			while((Adjmatrix[v][u]==2)&&(exist==1)){  //szukamy pierwszej krawędzi która nie jest mostem
		        	exist=0;
				var k=u+1;                             
				while((k<this.noOfVertices)&&(exist==0)){
					if(Adjmatrix[v][k]!=0){
						exist=1;                       
					}
					else{
						k++;
					}
				}
				if(exist==1){  //istnieje inna krawędź
					u=k;	
				}
			}
			Adjmatrix[v][u]=0;     //usuwamy krawędź v-u z grafu
			Adjmatrix[u][v]=0;
			v=u;     //przechodzimy do wierzchołka u
		}
	}
	//teraz sprawdzę czy użytkownik w odpowiedni sposób podał usunięte krawędzie i cykl eulera
	var edges=spl[1].split(" ");
        if(edges.length+1!=S.length){
		alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
	}
	var blad=0;
	var i=0;
	var j=0;
	while((i<S.length-1)&&(blad==0)){
		if((edges[j].length!=5)||(edges[j].substr(2,1)!="-")){
			alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");  //wyjątki użytkowników
		}
		var edge1=edges[j].substr(1,1)-1;
		var edge2=edges[j].substr(4,5)-1;
		if((S[i]!=edge1)||(S[i+1]!=edge2)){
			alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
                        blad=1;
		}
		j++;
		i++;
	}
	//teraz sprawdzam czy użytkownik prawidłowo podał cykl Eulera ,użytkownik może go podać także w odwrotnej kolejnośći
	var cycle=spl[2].split(" ");
	if(cycle.length!=S.length){
		alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
	}
	i=S.length-1;
	j=0;
	blad=0;
	while((i>=0)&&(blad==0)){
		if(cycle[j].length!=2){
			alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
		}
		if(S[i]!=cycle[j].substr(1,2)-1){
			blad=1;
		}
		j++;
		i--; 
	}
	if(blad==1){
		i=0;
		j=0;
		blad=0;
		while((i<S.length)&&(blad==0)){
			if(cycle[j].length!=2){
				alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
		        }
			if(S[i]!=cycle[j].substr(1,2)-1){
				blad=1;
			}
			j++;
			i++;
		} 
	}
	if(blad==1){
		alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
	}
	alert("Gratulacje! Ćwiczenie zostało prawidłowo wykonane.");
      }
      //funkcja ustawiająca tekst do ćwiczenia z algorytmu dijkstry
      dijsktra_exercise_text(context){
	var text="W polu tekstowym poniżej wpisz opis algorytmu Dijkstry dla danego grafu: podaj wierzchołek startowy, kolejno usuwane wierzchołki ze zbioru Q, ostateczną postać tablicy d i końcową postać 		tablicy p, w tablicy p wierzchołkowi startowemu przypisz jego samego. Przy opisie algorytmu uwzględnij to, że przy wyborze  wierzchołka o minimalnej wartości w tablicy d ze zbioru Q postępujemy 	następująco: jeśli jest kilka tych samych minimalnych wartości to wybieramy wierzchołek, którego wartość sprawdzaliśmy jako ostatnią. Dane podawaj w następującym formacie: v1,v1 v5 v4 v6 v2,v1-4  		v2-10 v3-15,v1-v1 v2-v3 v3-v4. Gdy będziesz gotowy  nacisnij przycisk check ,aby sprawdzić ćwiczenie. Wagi krawędzi w grafie przedstawiają się natępująco: ";
	for(var i=0;i<this.noOfVertices-1;i++){
		var list=this.EdgesWeight.get(i);
		for(var j=i+1;j<list.length;j++){
			if(list[j]!=0){
				text=text+"v"+String(i+1)+"-v"+String(j+1)+"("+String(list[j])+") ";
			}
		}
	}
	context[0].innerHTML=text+".";
      }
     //funkcja sprawdzająca ćwiczenie z algorytmu dijkstry
     check_dijsktra(str){
	var spl=str.split(",");
        if((spl.length!=4)||(spl[0].length!=2)){
		alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
	}
	var v=spl[0].substr(1,2)-1;
	var v_start=v;
	var del=[];                            //tablica na kolejno usuwane wierzchołki ze zbioru Q
	var d=[];
	d.push(0);
	for(var i=0;i<this.noOfVertices-1;i++){             //przygotowanie tablicy d
		d.push(200000);
	}
	var p=[];
	for(var i=0;i<this.noOfVertices;i++){              //przygotowujemy tablicę p
		p.push(-1);
	}
	p[v_start]=v_start;
	var Q=[];
	for(var i=0;i<this.noOfVertices;i++){               //przygotowuje zbiór Q
		Q.push(i);
	}
	while(Q.length>=1){
		var minimum=d[Q[0]];
		var minind=0;
		for(var i=0;i<Q.length;i++){
			if(d[Q[i]]<=minimum){
				minimum=d[Q[i]];
				minind=i;
			}
		}                         //wyznaczamy ze zbioru Q element o minimalnej wartości d[i]
		v=Q[minind];
		del.push(v);
		Q.splice(minind,1);
		var list=this.AdjList.get(v);
		for(var j=0;j<list.length;j++){        //sprawdzamy każdego sąsiada v
			var u=list[j];
			var znaleziony=0;
			var k=0;
			while((k<Q.length)&&(znaleziony==0)){
				if(Q[k]==u){
					znaleziony=1;
				}                               //sprawdzamy czy sąsiad jest w Q
				k++;
			}
			if(znaleziony==1){
				var w=this.EdgesWeight.get(v)[u];
				if(d[u]>(d[v]+w)){
					d[u]=d[v]+w;
					p[u]=v;
				}
			}
		}
	}
	var qvert=spl[1].split(" ");
	if(qvert.length!=del.length){                                 //sprawdzam czy użytkownik prawidłowo wypisał usunięte wierzchołki ze zbioru Q
		alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
	}
	for(var i=0;i<del.length;i++){
		if(qvert[i].length!=2){
			alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
		}
		if(del[i]!=qvert[i].substr(1,2)-1){
			alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
		}
	}
	var dtab=spl[2].split(" ");
	if(dtab.length!=d.length){                                 //sprawdzam czy użytkownik prawidłowo wypisał elementy tablicy d
		alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
	}
	for(var i=0;i<d.length;i++){
		if(d[i]<10){
			if((dtab[i].length!=4)||(dtab[i].substr(2,1)!="-")){
				alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
			}
			if((i!=dtab[i].substr(1,1)-1)||(d[i]!=dtab[i].substr(3,3))){
				alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
			}
		}
		else{
			if((dtab[i].length!=5)||(dtab[i].substr(2,1)!="-")){
				alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
			}
			if((i!=dtab[i].substr(1,1)-1)||(d[i]!=dtab[i].substr(3,4))){
				alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
			}
		}
			
	}
	var ptab=spl[3].split(" ");
	if(ptab.length!=p.length){                                 //sprawdzam czy użytkownik prawidłowo wypisał elementy tablicy p
		alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
	}
	for(var i=0;i<p.length;i++){
		 if((ptab[i].length!=5)||(ptab[i].substr(2,1)!="-")){
			alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
		 }
		 if((i!=ptab[i].substr(1,1)-1)||(p[i]!=ptab[i].substr(4,5)-1)){
			alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
		 }
	}
	alert("Gratulacje! Cwiczenie zostało prawidłowo wykonane.");
     }
      //funkcja ustawiająca tekst do ćwiczenia z algorytmu Prima
      prim_exercise_text(context){
	var text="W polu tekstowym poniżej wpisz opis algorytmu Prima dla danego grafu, podaj wierzchołek startowy i ostateczną postać minimalnego drzewa rozpinającego. Weź pod uwagę, że przy wyborze 		krawędzi o minimalnej wadze postępujemy w następujący sposób: jeśli jest kilka tych samych minimalnych wartości to wybieramy krawędź, której wartość sprawdzaliśmy jako ostatnią. Dane podawaj w 		następującym formacie: v1,v1-v2 v3-v4 itp. Gdy będziesz gotowy nacisnij przycisk check, aby sprawdzić ćwiczenie. Wagi krawędzi w grafie przedstawiają się natępująco: ";
	for(var i=0;i<this.noOfVertices-1;i++){
		var list=this.EdgesWeight.get(i);
		for(var j=i+1;j<list.length;j++){
			if(list[j]!=0){
				text=text+"v"+String(i+1)+"-v"+String(j+1)+"("+String(list[j])+") ";
			}
		}
	}
	context[0].innerHTML=text+".";
      }
     //funkcja do sprawdzania poprawności ćwiczenia z algorytmu Prima
     check_prim(str){
	var n=this.noOfVertices;
	var spl=str.split(",");
        if(spl.length!=2){
		alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");          //sprawdzamy wyjątki dla użytkownika
      	}
      	else{
           if((spl[0].length==0)||(spl[1].length==0)){
		alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
           }
     	}
	if(spl[0].length!=2){
		alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
	}
	var v_start=spl[0].substr(1,2)-1;
	var v=v_start;
	var Q=new Map();        //zbiór krawędzi grafu z wagami
	for(var i=0;i<this.noOfVertices;i++){
		Q.set(i,[]);
		for(var j=0;j<this.noOfVertices;j++){
			Q.get(i).push(0);
		}
	}
	var T=[];                //zbiór w którym powstanie minimalne drzewo rozpinające grafu
	var visited=[];
	for(var i=0;i<this.noOfVertices;i++){
		visited.push("F");
	}
	visited[v]="T";
	var u;
	for(var k=0;k<n-1;k++){
		var list=this.AdjList.get(v);
		for(var j=0;j<list.length;j++){
			u=list[j];
			if(visited[u]=="F"){
				Q.get(v)[u]=this.EdgesWeight.get(v)[u];
			}
		}
			var minimum=2000;
			var min_i=0;
			var min_j=0;
			var i=0;
			while(i<this.noOfVertices){
				for(j=0;j<this.noOfVertices;j++){
					if(Q.get(i)[j]!=0){
						if(Q.get(i)[j]<=minimum){
							minimum=Q.get(i)[j];
							min_i=i;
							min_j=j;
						}
					}
				}
				i++;
			}
			Q.get(min_i)[min_j]=0;
			while(visited[min_j]=="T"){
				 minimum=2000;
				 min_i=0;
				 min_j=0;
				 i=0;
				while(i<this.noOfVertices){
					for(j=0;j<this.noOfVertices;j++){
						if(Q.get(i)[j]!=0){
							if(Q.get(i)[j]<=minimum){
								minimum=Q.get(i)[j];
								min_i=i;
								min_j=j;
							}
						}
					}
					i++;
				}
				Q.get(min_i)[min_j]=0;
			}
			v=min_i;
			u=min_j;
			T.push({x:v,y:u});
			visited[u]="T";
			v=u;
	}
	var tab=spl[1].split(" ");          //sprawdzamy czy użytkownik podał minimalne drzewo rozpinające zgodnie z algorytmem prima
	if(tab.length!=T.length){
		alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
	}
	for(var i=0;i<T.length;i++){
		 if((tab[i].length!=5)||(tab[i].substr(2,1)!="-")){
			alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
		 }
		 if((T[i].x!=tab[i].substr(1,1)-1)||(T[i].y!=tab[i].substr(4,5)-1)){
			alert("Niestety ćwiczenie jest wykonane w sposób nieprawidłowy, spróbuj jeszcze raz.");
		 }
	}
	alert("Gratulacje! Ćwiczenie zostało wykonane prawidłowo.");
   }
}   
//funkcja do visualizacji grafu
function visual(container,data_table,n){
var cy =cytoscape({
        container: container,
	elements: [
	],
	  style: [
    		{
        selector: 'node',
        style: {
            'background-color': 'red',
            label: 'data(id)',
	    width: '50px',
	    height: '50px',
	    shape: 'ellipse',
	    "font-size" : '35px'
        }
    }]
      });

      if(global_option==0){
       for(var i=0;i<n;i++){
	cy.add({
        data: { id: 'v'+String(i+1) }
    	});
       }
      }
      else{
	for(var i=0;i<n;i++){
		var znaleziony=0;                          //opcja aby w przykładzie dla algorytmu Prima i Dijskstry nie wyświetlał całego grafu tylko odpowiednie drzewa
		var j=0;
		while((j<data_table.length)&&(znaleziony==0)){
			if(data_table[j]==i){
				znaleziony=1;
			}
		        j++;
		}
		if(znaleziony==1){
			cy.add({
        			data: { id: 'v'+String(i+1) }
    			});
		}
	}
      }
      var i=0;
      while(i<data_table.length-1){
	cy.add({
	   data: {
            source: 'v'+String(data_table[i]+1),
            target: 'v'+String(data_table[i+1]+1)
        }
       });
       i=i+2;
      }
       cy.layout({
    	name: 'cose',
	animation: 'false',
        randomize: 'true'
      });
      cy.maxZoom(0.6);
}




















