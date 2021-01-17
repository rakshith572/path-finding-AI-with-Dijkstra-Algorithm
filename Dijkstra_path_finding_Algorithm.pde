import java.util.*;
// auther name : Rakshith Gowda
// shortest path Algorithm Dijkstra


// creating a 2d array 
int spot[][];

// creating a 2d boolean array to check wheather is it processid or not
boolean [][]visited;
int rows=50;
int columns=50;
int w;

// creating a priorityQueue to get minimum Value around it
PriorityQueue<pair>pq=new PriorityQueue<pair>(new Comparator<pair>() {
  public int compare(pair a, pair b) {
    return a.dist-b.dist;
  }
});

HashMap<Integer, pair>hm;
int h;

// cost arry is for to get shortest path cost from origin
int cost[][];
int distance[][];
void setup() {
// size of canvas
  size(400, 400);
  
// declaring spo 2d array
  spot=new int[rows][columns];
  visited = new boolean[rows][columns];
  cost=new int[rows][columns];
  distance = new int[rows][columns];
  hm=new HashMap<Integer, pair>();
  w = (width)/columns;
  h = (height)/rows;
  
// creating a wall for path 
  for (int i=0; i<rows; i++) {
    for (int j=0; j<columns; j++) {
      float x=random(1);
      if (x<0.4) {
        spot[i][j]=1;
      } else {
        spot[i][j]=0;
      }
    }
  }
  
  spot[0][0]=0;
  spot[1][1]=0;
  
// the distance array which has value of distance from origin(0,0)
  for (int i=0; i<rows; i++) {
    for (int j=0; j<columns; j++) {
      cost[i][j]=Integer.MAX_VALUE;
      distance[i][j]=calculateDistance(0, 0, i*w, j*h);
    }
  }
  pq.add(new pair(0, 0, 0));
  hm.put(distance[0][0], pq.peek());
  visited[0][0]=true;
  //frameRate(5);
}
void draw() {
  background(255);
  
// drawing wall for which value of spot[index][index] is 1
  for (int i=0; i<rows; i++) {
    for (int j=0; j<columns; j++) {
      if (spot[i][j]==1) {
        drawEllipse(i, j);
      }
    }
  }
 
 // these is the directions for columns and rows which moves up, down , right, left ,and diagonals 
  int []i_dir = {1, 0, -1, 0, 1, -1, 1, -1};
  int []j_dir = {0, 1, 0, -1, 1, 1, -1, -1};
  
  //boolean occured =false;
// taking the current shortest cost  for selecting next step
  pair curr = pq.poll();
  
// when the current is null it means you haven't found the path   
  if (curr==null) {
    noLoop();
    print("you got scholled son !!!!!!");
    return;
  }
  int i =curr.i;
  int j = curr.j;
  
// these is when you have reach the destination  
  if (i==rows-1 && j==columns-1) {
    noLoop();
    print("Well Done man you got pretty Dope scence of Humar bro !!!!!!!");
  }
  
// we should make the curr position as true to make it is processed
  visited[i][j]=true;
  
// moving all direction (i.e)  up ,down , left , right ,and diagonall
  for (int k=0; k<8; k++) {
    int ii = i+i_dir[k];
    int jj = j+j_dir[k];
    
 //  these is to check the index of up ,down , left , right ,and diagonall are inside the sot matrix 
    if (isSafe(ii, jj) && cost[ii][jj] > distance[ii][jj]+curr.dist) {
      cost[ii][jj] = distance[ii][jj]+curr.dist;
      hm.put(distance[ii][jj], new pair(ii, jj, cost[ii][jj]));
      pq.add(hm.get(distance[ii][jj]));
      hm.get(distance[ii][jj]).prev = curr;
    }
  }
  
// these arrayList contain the path from orgin   
  ArrayList<pair>path=new ArrayList<pair>();
  pair temp = curr;
  path.add(temp);
  
// filling the arrayList by moving backwards by previous variable
  while (temp.prev!=null) {
    path.add(temp.prev);
    temp=temp.prev;
  }
  //print(path.size()+" ");
  noFill();
  stroke(255, 0, 200,100);
  strokeWeight(w / 2);
  beginShape();
  
// drawing a vertex (or) line 
  for (int k = path.size()-1; k >= 0; k--) {
    vertex(path.get(k).i * w + w / 2, path.get(k).j * h + h / 2);
  }
  endShape();
}
boolean isSafe(int i, int j) {
  return (i<columns && j< rows && i>=0 && j>=0 && spot[i][j]==0 && !visited[i][j]);
}

// it draws an ellipse 
void drawEllipse(int i, int j) {
  fill(0);
  noStroke();
  ellipse(i*w +w/2, j*h + h/2, w/2, h/2);
}

// it calvulate distance from the given points
int calculateDistance(int i, int j, int i1, int j1) {
  return (int)dist(i, j, i1, j1);
}
