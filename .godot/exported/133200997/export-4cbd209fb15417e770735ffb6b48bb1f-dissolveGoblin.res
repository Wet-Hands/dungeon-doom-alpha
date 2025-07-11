RSRC                    VisualShader            ��������                                            �      resource_local_to_scene    resource_name    output_port_for_preview    default_input_values    expanded_output_ports    parameter_name 
   qualifier    texture_type    color_default    texture_filter    texture_repeat    texture_source    script    source    texture 	   function    hint    min    max    step    default_value_enabled    default_value 	   operator    op_type    noise_type    seed 
   frequency    offset    fractal_type    fractal_octaves    fractal_lacunarity    fractal_gain    fractal_weighted_strength    fractal_ping_pong_strength    cellular_distance_function    cellular_jitter    cellular_return_type    domain_warp_enabled    domain_warp_type    domain_warp_amplitude    domain_warp_frequency    domain_warp_fractal_type    domain_warp_fractal_octaves    domain_warp_fractal_lacunarity    domain_warp_fractal_gain    width    height    invert    in_3d_space    generate_mipmaps 	   seamless    seamless_blend_skirt    as_normal_map    bump_strength 
   normalize    color_ramp    noise    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/3/node    nodes/fragment/3/position    nodes/fragment/5/node    nodes/fragment/5/position    nodes/fragment/6/node    nodes/fragment/6/position    nodes/fragment/7/node    nodes/fragment/7/position    nodes/fragment/8/node    nodes/fragment/8/position    nodes/fragment/9/node    nodes/fragment/9/position    nodes/fragment/10/node    nodes/fragment/10/position    nodes/fragment/11/node    nodes/fragment/11/position    nodes/fragment/12/node    nodes/fragment/12/position    nodes/fragment/13/node    nodes/fragment/13/position    nodes/fragment/14/node    nodes/fragment/14/position    nodes/fragment/15/node    nodes/fragment/15/position    nodes/fragment/16/node    nodes/fragment/16/position    nodes/fragment/17/node    nodes/fragment/17/position    nodes/fragment/18/node    nodes/fragment/18/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections    
   Texture2D 5   res://assets/enemies/textures/skeleton_baseColor.png �R�E=�   1   local://VisualShaderNodeTexture2DParameter_13nth �      &   local://VisualShaderNodeTexture_u21nb D      (   local://VisualShaderNodeFloatFunc_b7hcr �      $   local://VisualShaderNodeRemap_elgfo �      -   local://VisualShaderNodeFloatParameter_2d0k1 D      &   local://VisualShaderNodeFloatOp_kurjb �      &   local://VisualShaderNodeFloatOp_tf6ny �      #   local://VisualShaderNodeStep_kkl77 )         local://FastNoiseLite_50v64 �         local://NoiseTexture2D_ld2ph �      &   local://VisualShaderNodeTexture_r0lre       &   local://VisualShaderNodeFloatOp_pam5o O      -   local://VisualShaderNodeColorParameter_jjo57 �      "   local://VisualShaderNodeMix_orfoc �      -   local://VisualShaderNodeFloatParameter_i4sgy }      ,   local://VisualShaderNodeVectorCompose_i4mlr �      '   local://VisualShaderNodeVectorOp_v840l       -   local://VisualShaderNodeFloatParameter_jm5oe A         local://VisualShader_bnfdf �      #   VisualShaderNodeTexture2DParameter             Texture                            VisualShaderNodeTexture                                                   VisualShaderNodeFloatFunc                       VisualShaderNodeRemap                        ��           �?                        �?         VisualShaderNodeFloatParameter             Speed                  �?         VisualShaderNodeFloatOp                      VisualShaderNodeFloatOp                                 )   �������?         VisualShaderNodeStep                                                                                  FastNoiseLite                               NoiseTexture2D    8                     VisualShaderNodeTexture                             	            VisualShaderNodeFloatOp                      VisualShaderNodeColorParameter             LightColor                    ��T?      �?         VisualShaderNodeMix                                                  �?  �?  �?  �?            ?   ?   ?   ?                  VisualShaderNodeFloatParameter             LightStrength                  �?         VisualShaderNodeVectorCompose             VisualShaderNodeVectorOp                      VisualShaderNodeFloatParameter             ShaderTime                  �@         VisualShader $   9      (  shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_lambert, specular_schlick_ggx;

uniform sampler2D Texture : source_color, hint_default_transparent;
uniform sampler2D tex_frg_11;
uniform float LightStrength = 1;
uniform vec4 LightColor : source_color = vec4(0.000000, 0.831373, 0.000000, 1.000000);
uniform float ShaderTime = 4.5;
uniform float Speed = 1;



void fragment() {
	vec4 n_out3p0;
// Texture2D:3
	n_out3p0 = texture(Texture, UV);
	float n_out3p4 = n_out3p0.a;


// Texture2D:11
	vec4 n_out11p0 = texture(tex_frg_11, UV);
	float n_out11p1 = n_out11p0.r;


// FloatOp:12
	float n_out12p0 = n_out3p4 - n_out11p0.x;


// FloatParameter:15
	float n_out15p0 = LightStrength;


// VectorCompose:16
	vec3 n_out16p0 = vec3(n_out15p0, n_out15p0, n_out15p0);


// ColorParameter:13
	vec4 n_out13p0 = LightColor;


// FloatParameter:18
	float n_out18p0 = ShaderTime;


// FloatParameter:7
	float n_out7p0 = Speed;


// FloatOp:8
	float n_out8p0 = n_out18p0 * n_out7p0;


// FloatFunc:5
	float n_out5p0 = sin(n_out8p0);


	float n_out6p0;
// Remap:6
	float n_in6p1 = -1.00000;
	float n_in6p2 = 1.00000;
	float n_in6p3 = 0.00000;
	float n_in6p4 = 1.00000;
	{
		float __input_range = n_in6p2 - n_in6p1;
		float __output_range = n_in6p4 - n_in6p3;
		n_out6p0 = n_in6p3 + __output_range * ((n_out5p0 - n_in6p1) / __input_range);
	}


// FloatOp:9
	float n_in9p1 = 0.10000;
	float n_out9p0 = n_out6p0 + n_in9p1;


// Mix:14
	vec4 n_in14p0 = vec4(0.00000, 0.00000, 0.00000, 0.00000);
	vec4 n_out14p0 = mix(n_in14p0, n_out13p0, vec4(n_out9p0));


// Step:10
	vec4 n_out10p0 = step(vec4(n_out11p1), n_out14p0);


// VectorOp:17
	vec3 n_out17p0 = n_out16p0 * vec3(n_out10p0.xyz);


// Output:0
	ALBEDO = vec3(n_out3p0.xyz);
	ALPHA = n_out12p0;
	EMISSION = n_out17p0;
	ALPHA_SCISSOR_THRESHOLD = n_out6p0;


}
 T   
    ��D  DU             V   
     �D  aDW            X   
     �D  pDY            Z   
     zD   D[            \   
    ��D  /D]            ^   
     D  CD_            `   
     WD  �Ca            b   
     �D  Dc            d   
    ��D  �Ce         
   f   
     �D  HDg            h   
     �D ��Di            j   
    ��D  �Ck            l   
    ��D  �Cm            n   
     MD  MDo            p   
     �D  *Dq            r   
     �D  �Cs            t   
     D  Du       T                                                                                             	             
                    	                    
                                                           
                                                                                        RSRC