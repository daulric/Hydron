local ref = {
    __tostring = "Hydron: Ref",
}

function useRef()
    return {
        current = nil,
        isRefed = false
    }
end


return {
    Ref = ref,
    useRef = useRef,
}