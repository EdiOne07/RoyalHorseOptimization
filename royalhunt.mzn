include "globals.mzn";
int: n; % number of court members
set of int: COURT = 1..n;
int: emperor = 1;
array[COURT] of int: rank;
array[COURT] of int: ability;

int: m; % number of horses
set of int: HORSE = 1..m;
array[HORSE] of int: beauty;
array[HORSE] of int: speed;

array[COURT,HORSE] of int: enjoy;
array[COURT] of var 0..m: horse;  % 0 = not riding  
var int: objective;
constraint alldifferent_except_0(horse);
constraint (m>=n)->(forall(i in COURT)(horse[i]>0));
constraint (n>m)->(sum(i in COURT)(horse[i]>0)==m);
constraint forall( i in COURT where i!=emperor)(horse[i]>0 ->(enjoy[emperor,horse[emperor]]>enjoy[i,horse[i]]));
constraint forall(i,j in COURT where rank[i]>rank[j])((horse[i]>0 /\ horse[j]>0 /\ beauty[horse[i]]>=beauty[horse[j]])\/(horse[j]=0)\/(horse[i]=0 /\ horse[j]=0));
var int:speed_violation=100*sum(i,j in COURT where i!=j)(horse[i]>0 /\ horse[j]>0 /\ speed[horse[i]]>speed[horse[j]] /\ability[i]<ability[j]);
var int: enjoyment= sum(i in COURT where horse[i]>0)(enjoy[i,horse[i]]);
objective=enjoyment-speed_violation;
solve maximize objective;