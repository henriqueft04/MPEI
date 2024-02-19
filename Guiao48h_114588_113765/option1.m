function visited_restaurantes_id = option1(restaurants_ids, rest)

    restaurants_ids = sort(restaurants_ids);
    fprintf('%3s | %-40s | %s \n', 'ID','Name','County');
    fprintf('%3s | %-40s |%s\n','---','----------------------------------------','----------');
    visited_restaurantes_id = [];
    for i = 1:length(restaurants_ids)
        for j = 1:length(rest)
            if restaurants_ids(i) == cell2mat(rest(j,1))
                fprintf('%3d | %-40s | %s \n', restaurants_ids(i),cell2mat(rest(j,2)),cell2mat(rest(j,4)));
                visited_restaurantes_id = [visited_restaurantes_id,restaurants_ids(i)];
            end
        end
    end
    fprintf('%3s | %-40s |%s\n','---','----------------------------------------','----------');
    fprintf('\n');
end