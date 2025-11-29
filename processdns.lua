function log2 (x) return math.log(x) / math.log(2) end
 
function entropy (X)
    local N, count, sum, i = X:len(), {}, 0
    for char = 1, N do
        i = X:sub(char, char)
        if count[i] then
            count[i] = count[i] + 1
        else
            count[i] = 1
        end
    end
    for n_i, count_i in pairs(count) do
        sum = sum + count_i / N * log2(count_i / N)
    end
    return -sum
end


function init (args)
    local needs = {}
    needs["payload"] = tostring(true)
    return needs
end

function match(args)
    a = tostring(args["payload"])
    if #a > 0 then
	local name = string.gsub(a:sub(14), '[%p%c%s]', '')
	local entropy = entropy(name)
	if entropy > 3 and entropy > ( log2(name:len()) * 0.85 ) then
	    return 1
	end
    end
    return 0
end
