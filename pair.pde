class pair{
// the ith index for rows
  int i;
  
// the jth index for columns  
  int j;
// these variable it hold of distance   
  int dist;
  
// these hold previous pair   
  pair prev;
  pair(int i,int j,int dist){
    this.i=i;
    this.j=j;
    this.dist=dist;
  }
}
