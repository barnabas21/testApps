<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class HomeController extends Controller
{
    public function __invoke(Type $var = null): array
    {
        return [
            'success' => true,
            'message' => "Bienvenue ...",
            'data' => [
                'nom' => 'ATABU',
                'prenoms' => 'Barnabas',
                'pseudo' => 'undertaker',
                'mdp' => '210599'
            ]
        ];
    }
}
