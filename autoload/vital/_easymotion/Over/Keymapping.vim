scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim



function! s:_vital_loaded(V)
	let s:V = a:V
	let s:String  = s:V.import("Over.String")
endfunction


function! s:_vital_depends()
	return [
\		"Over.String",
\	]
endfunction


function! s:as_key_config(config)
	let base = {
\		"noremap" : 0,
\		"lock"    : 0,
\		"expr"    : 0,
\	}
	return type(a:config) == type({}) ? extend(base, a:config)
\		 : extend(base, {
\		 	"key" : a:config,
\		 })
endfunction


function! s:match_key(keymapping, key)
	let keys = sort(keys(a:keymapping))
	return get(filter(keys, 'stridx(a:key, v:val) == 0'), -1, '')
endfunction


function! s:_safe_eval(expr, ...)
	call extend(l:, get(a:, 1, {}))
	let result = get(a:, 2, "")
	try
		let result = eval(a:expr)
	catch
		echohl ErrorMsg | echom v:exception | echohl None
	endtry
	return result
endfunction


function! s:_get_key(conf)
" 	call extend(l:, a:conf)
	let self = a:conf
	return get(a:conf, "expr", 0) ? s:_safe_eval(a:conf.key, l:) : a:conf.key
endfunction


function! s:unmapping(keymapping, key, ...)
	let is_locking = get(a:, 1, 0)
	let key = s:match_key(a:keymapping, a:key)
	if key == ""
		return s:String.length(a:key) <= 1 ? a:key : s:unmapping(a:keymapping, a:key[0], is_locking) . s:unmapping(a:keymapping, a:key[1:], is_locking)
	endif

	let map_conf = s:as_key_config(a:keymapping[key])

	let next_input = s:unmapping(a:keymapping, a:key[len(key) : ], is_locking)
	if map_conf.lock == 0 && is_locking
		return key . next_input
	elseif map_conf.lock
		return s:unmapping(a:keymapping, s:_get_key(map_conf), is_locking) . next_input
	else
		return s:unmapping(a:keymapping, s:_get_key(map_conf), map_conf.noremap) . next_input
	endif
endfunction



let &cpo = s:save_cpo
unlet s:save_cpo
