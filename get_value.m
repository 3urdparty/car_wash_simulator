function val = get_value(rn, ranges)
  for i = 1:size(ranges, 1)
    if rn >= ranges(i,2) && rn <= ranges(i,3)
      val = ranges(i,1);
      return ;
    end
  end
end
