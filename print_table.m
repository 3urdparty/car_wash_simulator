function print_table(mat)
  % Display a matrix as a table
  % Input: mat - the matrix to display as a table

  % Check if input is a matrix
  if ~ismatrix(mat)
    error('Input must be a matrix');
  end

  % Print the header
  printf('Service Time\tProb.\tCDF\tRange\n');
  printf('-------------\t-------\t-------\t-------\n');

  % Get the size of the matrix
  [rows, cols] = size(mat);

  % Print the header row

  % Print the matrix as a table
  for i = 1:rows
    printf('%3d\t\t%1.2f\t%1.2f\t%3d-%3d', mat(i,1), mat(i,2), mat(i,3), mat(i,4), mat(i,5));
    printf('\n');
  end
end
