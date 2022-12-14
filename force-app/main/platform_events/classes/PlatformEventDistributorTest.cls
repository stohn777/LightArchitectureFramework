/**
 * Copyright (c) 2020, John M. Daniel & John Storey
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, 
 *   are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice, 
 *      this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice, 
 *      this list of conditions and the following disclaimer in the documentation 
 *      and/or other materials provided with the distribution.
 * - Neither the name of the John M. Daniel, nor the names of its contributors 
 *      may be used to endorse or promote products derived from this software without 
 *      specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
 *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
 *  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
 *  THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 *  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 *  OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**/

@IsTest
public class PlatformEventDistributorTest
{
    @isTest
    private static void basicTestToActivateCodeCoverage() 
    {
        LafEvent__e platformEventbus = new LafEvent__e();

        platformEventbus.EventName__c = 'bluefish';
        platformEventbus.Category__c = Account.getSObjectType().getDescribe().getName();
        platformEventbus.Payload__c = json.serialize( new Set<Id>{ generateMockId(Account.SObjectType ) } );

        Test.startTest();
        Database.SaveResult sr = EventBus.publish(platformEventbus);
        Test.stopTest();

        System.assertEquals(true, sr.isSuccess());
    }

    private static Integer fakeIdCount = 0;
    private static final String ID_PATTERN = '000000000000';
    public static Id generateMockId(Schema.SObjectType sobjectType)
    {
        String keyPrefix = sobjectType.getDescribe().getKeyPrefix();
        fakeIdCount++;

        String fakeIdPrefix = ID_PATTERN.substring(0, 12 - String.valueOf(fakeIdCount).length());

        return Id.valueOf(keyPrefix + fakeIdPrefix + fakeIdCount);
    }
}
