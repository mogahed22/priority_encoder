vlib work
vlog priority_enc.v priority_enc_test.svh  +cover
vsim -voptargs=+acc work.priority_enc_test -cover
add wave *
coverage save priority_enc_test.ucdb -onexit
run -all