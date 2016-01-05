function v = read (filename, n, di, flg)
		%------------------------------Summary-----------------------------------
		
			%Used for reading data from files and creates .mat files which contain the desired data
			%You use this same funtion to read data points and also query points
			%If used for reading data points then 'data.mat' is created
			%If used for reading query points then 'querydata.mat' is creted
		
		%------------------------------Input-------------------------------------
		
			% filename = name of the file
			% n        = number of tuples
			% di       = dimension of the tuples
			% flg      = 1 or 0  

		%-------------------------------Output------------------------------------
		
			%File data.mat is created if flg = 1
			%If flg = 0 querydata.mat is created

		%------------------------------------------------------------------------ 


% open the file and count the number of descriptors
fid = fopen (filename, 'rb');
 
if fid == -1
  error ('I/O error : Unable to open the file %s\n', filename)
end
% Read the vector size
d = fread (fid, 1, 'int');

% read n vectors
v = fread (fid, (d + 1) * n ,'float=>single' );

v = reshape (v, d + 1, n);

v = v (1:di,:);
if flg == 1
  save data.mat v;
else
    save querydat.mat;
end
fclose (fid);
