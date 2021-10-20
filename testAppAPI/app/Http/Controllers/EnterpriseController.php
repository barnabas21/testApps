<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

use App\Models\Enterprise;

class EnterpriseController extends Controller
{
    //Save an enterprises
    public function storeEnterprise(Request $request)
    {
        return Enterprise::create(
            [
                'enterprise_name'=>$request->input('enterprise_name'),
                'num_cfe'=>$request->input('num_cfe'),
                'user_id'=>$request->input('user_id')
            ]
        );
    }

    //Get an user's enterprise
    public function getUserEnterprises(Enterprise $enterprise, Request $request)
    {
        $enterpriseQueried = Enterprise::where(['user_id'=>$enterprise->user_id])->get();
        return $enterpriseQueried;
    }

    //Get an enterprise
    public function getEnterprise(Enterprise $enterprise, Request $request)
    {
        $enterpriseQueried = Enterprise::where(['id'=>$enterprise->id])->get();
        return $enterpriseQueried;
    }

    //Delete enterprise
    public function deleteEnterprise(Request $request)
    {
        $enterprise = new Enterprise();
        $enterprise = Enterprise::where(['id'=>$request->input('id')])->first();

        return $enterprise->forceDelete();
    }
}
