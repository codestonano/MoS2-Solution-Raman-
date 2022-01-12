% define variables
% three directional angles: alpha, beta, gamma; 
% elements in Raman tensor: a, b, c, d, e, f
syms alpha beta gamma a b c d e f;

% input ANY Raman matrix here with a, b, c, d, e, and f. Here is the A1g mode for example
R =[a,0,0
0,a,0
0,0,b];

% Rotation Step 1: the rotation matrix around the z-axis with alpha
T_z1=[cos(alpha), -sin(alpha), 0,
sin(alpha), cos(alpha), 0,
 0, 0, 1];

% Rotation Step 2: the rotation matrix around the y-axis with beta
T_y2 =[cos(beta), 0, sin(beta),
 0, 1, 0,
 -sin(beta), 0, cos(beta)];

% Rotation Step 3: the rotation matrix around the z-axis with gamma
T_z3 =[cos(gamma), -sin(gamma), 0,
sin(gamma), cos(gamma), 0,
0,0,1];

% The final rotation matrix after rotating alpha, beta, gamma
T= T_z3*T_y2 *T_z1;

% The inverse matrix of the rotation matrix 
T_tran=T';

fprintf ('THANK YOU for working with us, the calculation may take a few minutes… \n')
fprintf ('calculating… \n')

% Raman matrix of the individual 2D nanosheet with rotational angle alpha, beta, gamma 
R_solution=T*R*T_tran;


% Calculate the Raman intensity when ei // es 
I_parallel=([1 0 0]*R_solution*[1;0;0])^2;
Int_parallel=int(int(int(I_parallel,alpha,0,2*pi)*sin(beta),beta,0,pi), gamma, 0, 2*pi);
Int_parallel=Int_parallel/4/pi/pi;

% Calculate the Raman intensity when ei + es 
I_cross=([0 1 0]*R_solution*[1;0;0])^2;
Int_cross=int(int(int(I_cross,alpha,0,2*pi)*sin(beta),beta,0,pi), gamma, 0, 2*pi);
Int_cross=Int_cross/4/pi/pi;

% Calculate the Raman intensity when the incident laser and Raman signal have the same helicity (+ +) in the solution
I_plus_plus=(1/2*[1 i 0]*R_solution*[1;-i;0])^2;
Int_plus_plus=int(int(int(I_plus_plus,alpha,0,2*pi)*sin(beta),beta,0,pi), gamma, 0, 2*pi);
I_plus_plus=I_plus_plus/4/pi/pi;

% Calculate the Raman intensity when the incident laser and Raman signal have the opposite helicity (+ -) in the solution
I_plus_minus=(1/2*[1 -i 0]*R_solution*[1;-i;0])^2;
Int_plus_minus=int(int(int(I_plus_minus,alpha,0,2*pi)*sin(beta),beta,0,pi), gamma, 0, 2*pi);
Int_plus_minus=Int_plus_minus/4/pi/pi;

%print results
fprintf ('\n for ei//es, the Raman intensity is \n')
Int_parallel=Int_parallel
fprintf ('\n for ei+es, the Raman intensity is \n')
Int_cross=Int_cross
fprintf ('\n for ei=sigma+, es=sigma+, the Raman intensity is \n ')
Int_plus_plus=Int_plus_plus
fprintf ('\n for ei=sigma+, es=sigma-, the Raman intensity is \n ')
Int_plus_minus=Int_plus_minus
fprintf ('\n THANK YOU for working with us, the calculation is finished…')