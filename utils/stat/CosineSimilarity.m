function cossim = CosineSimilarity(mat1,mat2)

nor1 = mat1/sqrt(mat1(1,:)*mat1(1,:)');
nor2 = mat2/sqrt(mat2(1,:)*mat2(1,:)');
cossim = dot(nor1,nor2);