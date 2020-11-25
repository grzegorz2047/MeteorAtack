function isPositive() 
    return math.random() > 0.5
end
  
function randomNumber(isPositive) 
rand = math.random(1, 5)
if isPositive then
    return rand
else 
    return -rand
end
end