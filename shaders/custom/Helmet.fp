/**
 * Copyright (c) 2017-2019 DRRP-Team
 * 
 * This software is released under the MIT License.
 * https://opensource.org/licenses/MIT
 */

uniform vec2 Scale;
uniform vec3 camerapos;

varying float lightlevel;

const vec3 POSTFILTER   = vec3(0.0,    0.0,    0.0);    // Фильтр для постобработки
const vec3 CORNERFILTER = vec3(0.1,    0.1,    0.25);   // Фильтр для затемнения
const vec3 CENTERFILTER = vec3(0.0,    0.0,    0.0);    // Фильтр для центра экрана
const float RIGIDITY    = 100.;                         // Жесткость затемнения боков

vec4 blur9(sampler2D image, vec2 uv, vec2 resolution, vec2 direction) {
    vec4 color = vec4(0.0);
    vec2 off1 = vec2(1.3846153846) * direction;
    vec2 off2 = vec2(3.2307692308) * direction;
    color += texture2D(image, uv) * 0.2270270270;
    color += texture2D(image, uv + (off1 / resolution)) * 0.3162162162;
    color += texture2D(image, uv - (off1 / resolution)) * 0.3162162162;
    color += texture2D(image, uv + (off2 / resolution)) * 0.0702702703;
    color += texture2D(image, uv - (off2 / resolution)) * 0.0702702703;
    return color;
}

vec3 ProcessColor(vec3 color) {
    vec2 uv = TexCoord;
    uv *= 1.0 - uv.yx;
    float vig = min(pow(uv.x * uv.y * RIGIDITY, .25), 1.);
    float cornermask = 1.-vig; //Маска бокового затемнения
    vec3 blur = blur9(InputTexture, TexCoord, Scale, vec2(0.7, 0.7)).rgb;

    // TODO: Поработать над достоверностью заломления
    float x = cos(TexCoord.x + .5) - sin(TexCoord.y);
    float y = sin(TexCoord.x + .5) + cos(TexCoord.y + .3); //FIXME: Подправить Y
    vec4 d = texture(InputTexture, vec2(x, y)); // Текстура отражения от шлема

    color = color * vig + (d.rgb * cornermask / 2) + max(vec3(0), blur * (cornermask - .5)) + (CENTERFILTER * vig) + (CORNERFILTER * cornermask) + POSTFILTER;
    return color;
}

float ProcessAlpha(float alpha) {
    return alpha;
}

void main() {
    vec4 c = texture(InputTexture, TexCoord);
    vec3 color = ProcessColor(c.rgb);
    float alpha = ProcessAlpha(c.a);

    FragColor = vec4(color, alpha);
}
