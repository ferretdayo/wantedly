/* tslint:disable:no-unused-variable */

import { TestBed, async, inject } from '@angular/core/testing';
import { SkillService } from './skill.service';

describe('SkillService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [SkillService]
    });
  });

  it('should ...', inject([SkillService], (service: SkillService) => {
    expect(service).toBeTruthy();
  }));
});
