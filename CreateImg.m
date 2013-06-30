function out = CreateImg(ref, tst, grid_size)
    l1 = length(ref);
    l2 = length(tst);
    cols = [l1 l2];
    img_width = max(l1, l2)*grid_size;
    img_height = grid_size*2;
    out = zeros(img_height, img_width, 3);
    for row = 1:2
        for col = 1:cols(row)
            color_patch = zeros(grid_size,grid_size);
            if (row==1)
                color_patch(:,:,1) = ref(col,1)*ones(grid_size,grid_size);
                color_patch(:,:,2) = ref(col,2)*ones(grid_size,grid_size);
                color_patch(:,:,3) = ref(col,3)*ones(grid_size,grid_size);
            else
                color_patch(:,:,1) = tst(col,1)*ones(grid_size,grid_size);
                color_patch(:,:,2) = tst(col,2)*ones(grid_size,grid_size);
                color_patch(:,:,3) = tst(col,3)*ones(grid_size,grid_size);
            end
            out((row-1)*grid_size+1:row*grid_size,(col-1)*grid_size+1:col*grid_size,:) = color_patch;
        end
    end