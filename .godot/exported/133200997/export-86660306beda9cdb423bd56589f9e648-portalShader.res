RSRC                    VisualShader            ��������                                            V      resource_local_to_scene    resource_name    output_port_for_preview    default_input_values    expanded_output_ports    source    texture    texture_type    script 	   function    input_name    op_type 	   operator    parameter_name 
   qualifier    default_value_enabled    default_value    hint    min    max    step    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/3/node    nodes/fragment/3/position    nodes/fragment/4/node    nodes/fragment/4/position    nodes/fragment/5/node    nodes/fragment/5/position    nodes/fragment/7/node    nodes/fragment/7/position    nodes/fragment/8/node    nodes/fragment/8/position    nodes/fragment/9/node    nodes/fragment/9/position    nodes/fragment/10/node    nodes/fragment/10/position    nodes/fragment/11/node    nodes/fragment/11/position    nodes/fragment/13/node    nodes/fragment/13/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections    
   Texture2D "   res://assets/portal/portal128.png �]5��`;
   Texture2D )   res://assets/portal/T_VFX_CircleFit1.png �p�1�#   &   local://VisualShaderNodeTexture_k0xvx Q      +   local://VisualShaderNodeUVPolarCoord_qqq5l �      %   local://VisualShaderNodeUVFunc_0mlf6 �      $   local://VisualShaderNodeInput_ecw6k �      '   local://VisualShaderNodeVectorOp_kwmg2 4      &   local://VisualShaderNodeTexture_pkn44 �      -   local://VisualShaderNodeColorParameter_etj3d       '   local://VisualShaderNodeVectorOp_w7wjg G      -   local://VisualShaderNodeFloatParameter_ieloi �      '   local://VisualShaderNodeVectorOp_mrflo          local://VisualShader_clwey 9         VisualShaderNodeTexture                                                   VisualShaderNodeUVPolarCoord             VisualShaderNodeUVFunc             VisualShaderNodeInput    
         time          VisualShaderNodeVectorOp                    
                 
   �������>                            VisualShaderNodeTexture                                                  VisualShaderNodeColorParameter             ColorParam          VisualShaderNodeVectorOp                    
                 
                                       VisualShaderNodeFloatParameter             IntenseParam          VisualShaderNodeVectorOp                      VisualShader          �  shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_disabled, diffuse_lambert, specular_schlick_ggx;

uniform sampler2D tex_frg_2 : source_color;
uniform vec4 ColorParam : source_color;
uniform float IntenseParam;



void fragment() {
	vec2 n_out3p0;
// UVPolarCoord:3
	vec2 n_in3p1 = vec2(0.50000, 0.50000);
	float n_in3p2 = 1.00000;
	float n_in3p3 = 1.00000;
	{
		vec2 __dir = UV - n_in3p1;
		float __radius = length(__dir) * 2.0;
		float __angle = atan(__dir.y, __dir.x) * 1.0 / (PI * 2.0);
		n_out3p0 = vec2(__radius * n_in3p2, __angle * n_in3p3);
	}


// Input:5
	float n_out5p0 = TIME;


// VectorOp:7
	vec2 n_in7p1 = vec2(-0.30000, 0.30000);
	vec2 n_out7p0 = vec2(n_out5p0) * n_in7p1;


// UVFunc:4
	vec2 n_in4p1 = vec2(1.00000, 1.00000);
	vec2 n_out4p0 = n_out7p0 * n_in4p1 + n_out3p0;


// Texture2D:2
	vec4 n_out2p0 = texture(tex_frg_2, n_out4p0);
	float n_out2p1 = n_out2p0.r;


// ColorParameter:9
	vec4 n_out9p0 = ColorParam;


// FloatParameter:11
	float n_out11p0 = IntenseParam;


// VectorOp:13
	vec3 n_out13p0 = vec3(n_out9p0.xyz) * vec3(n_out11p0);


// VectorOp:10
	vec2 n_out10p0 = vec2(n_out2p1) * vec2(n_out13p0.xy);


// Output:0
	ALBEDO = vec3(n_out10p0, 0.0);
	EMISSION = vec3(n_out10p0, 0.0);


}
          0   
    ��D   C1             2   
     4D  ��3            4   
     �C  ��5            6   
     �C  p�7            8   
     p�  �B9            :   
     �C  pB;            <   
     \D  �C=            >   
     �B  \C?            @   
     pD    A            B   
     C  �CC         	   D   
     D  \CE       (                                                          
               	                                  
            
       
                    RSRC