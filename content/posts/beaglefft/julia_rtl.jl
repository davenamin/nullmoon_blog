using FFTW
ccall((:rtlsdr_get_device_count, :librtlsdr), Int64, ())

unsafe_string(ccall((:rtlsdr_get_device_name, :librtlsdr), Cstring, (Int64,), 0))

mutable struct rtlsdr_struct
end


# adapted from Julia 1.0 ccall docs
function open_rtlsdr(ix::Int64)
    rtl_ptr = Ref{Ptr{rtlsdr_struct}}()
    output_val = ccall(
        (:rtlsdr_open, :librtlsdr), # name of C function and library
        Int64, # output type
        (Ref{Ptr{rtlsdr_struct}}, Int64),    # tuple of input types
        rtl_ptr, ix # name of Julia variable to pass in
    )
    if (output_val != 0 || rtl_ptr[] == C_NULL) # Could not allocate memory
        throw(OutOfMemoryError())
    end
    return rtl_ptr[]
end

function close_rtlsdr(rtl)
    output_ptr = ccall(
        (:rtlsdr_close, :librtlsdr), # name of C function and library
        Int64, # output type
        (Ref{rtlsdr_struct},),    # tuple of input types
        rtl # name of Julia variable to pass in
    )
    return output_ptr
end


function get_centerfreq_rtlsdr(rtl)
    output_ptr = ccall(
        (:rtlsdr_get_center_freq, :librtlsdr), # name of C function and library
        Int64, # output type
        (Ref{rtlsdr_struct},),    # tuple of input types
        rtl # name of Julia variable to pass in
    )
    return output_ptr
end

function get_samplerate_rtlsdr(rtl)
    output_ptr = ccall(
        (:rtlsdr_get_sample_rate, :librtlsdr), # name of C function and library
        Int64, # output type
        (Ref{rtlsdr_struct},),    # tuple of input types
        rtl # name of Julia variable to pass in
    )
    return output_ptr
end


function get_tunertype_rtlsdr(rtl)
    output_ptr = ccall(
        (:rtlsdr_get_tuner_type, :librtlsdr), # name of C function and library
        Int64, # output type
        (Ref{rtlsdr_struct},),    # tuple of input types
        rtl # name of Julia variable to pass in
    )
    return output_ptr
end

function get_tunergains_rtlsdr(rtl)
    num_gains = ccall(
        (:rtlsdr_get_tuner_gains, :librtlsdr), # name of C function and library
        Int64, # output type
        (Ref{rtlsdr_struct}, Int64),    # tuple of input types
        rtl, C_NULL # name of Julia variable to pass in
    )

    output_arr = (zeros(Cint, num_gains))

    success = ccall(
        (:rtlsdr_get_tuner_gains, :librtlsdr), # name of C function and library
        Int64, # output type
        (Ref{rtlsdr_struct}, Ref{Cint}),    # tuple of input types
        rtl, output_arr # name of Julia variable to pass in
    )
    return output_arr
end

function set_centerfreq_rtlsdr(rtl, freq)
    output_ptr = ccall(
        (:rtlsdr_set_center_freq, :librtlsdr), # name of C function and library
        Int64, # output type
        (Ref{rtlsdr_struct}, Int64),    # tuple of input types
        rtl, freq # name of Julia variable to pass in
    )
    return output_ptr
end

function set_samplerate_rtlsdr(rtl, rate)
    output_ptr = ccall(
        (:rtlsdr_set_sample_rate, :librtlsdr), # name of C function and library
        Int64, # output type
        (Ref{rtlsdr_struct}, Int64),    # tuple of input types
        rtl, rate # name of Julia variable to pass in
    )
    return output_ptr
end




function reset_buffer_rtlsdr(rtl)
    output_ptr = ccall(
        (:rtlsdr_reset_buffer, :librtlsdr), # name of C function
        Int64, # output type
        (Ref{rtlsdr_struct}, ),    # tuple of input types
        rtl # name of Julia variable to pass in
    )
    return output_ptr
end


function set_agcmode_rtlsdr(rtl, agc::Bool)
    output_ptr = ccall(
        (:rtlsdr_set_agc_mode, :librtlsdr), # name of C function
        Int64, # output type
        (Ref{rtlsdr_struct}, Int64),    # tuple of input types
        rtl, agc # name of Julia variable to pass in
    )
    return output_ptr
end

function read_data_rtlsdr(rtl, request_size::Int64)
    output_arr = (zeros(UInt8, request_size))
    actual_read = Ref(0::Int64)
    success = ccall(
        (:rtlsdr_read_sync, :librtlsdr), # name of C function and library
        Int64, # output type
        (Ref{rtlsdr_struct}, Ref{UInt8},Int64,Ref{Int64}), # tuple of input types
        rtl, output_arr,request_size,actual_read# Julia variable to pass in
    )
    return output_arr
end



#=
97 900 000
96 900 000
95 900 000
=#

tuner = open_rtlsdr(0)

reset_buffer_rtlsdr(tuner)

get_centerfreq_rtlsdr(tuner)

get_tunertype_rtlsdr(tuner)

get_tunergains_rtlsdr(tuner)

set_agcmode_rtlsdr(tuner, true)

#set_centerfreq_rtlsdr(tuner, 96900000)
set_centerfreq_rtlsdr(tuner, 95900000)

sleep(5)
burn = read_data_rtlsdr(tuner, 16384)
data = read_data_rtlsdr(tuner, 16384)

close_rtlsdr(tuner)

transformed = fft(data)
