return function (class)
    return function (props)
        local node = {
            className = class,
            props = props,
            children = props.children or {},
            _object = Instance.new(class),
            _events = {},
        }

        return node
    end
end