
p = 1;
for ii=1:7-1
    for jj=ii+1:7
         if(ii~=9)
             l = 7-(ii-1);
             l1=6*(6+1)/2-((l-1)*((l))/2);
        fprintf('%d %d %d %d \n',ii, jj, p,l1+(jj-ii))
         else
%                      fprintf('%d %d %d %d \n',ii, jj, p,(jj-ii))

         end
%         +(jj-1)
%         ii*(jj-ii))
%   (7-(ii-1))+jj
        p=p+1;
    end
    
    
end

