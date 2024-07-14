return function (class)
    return function (props)
        if type(class) == "function" then
            return class(props)
        end

        local node = {
            className = class,
            props = props,
            children = props.children,
            _events = {},
        }

        return node
    end
end